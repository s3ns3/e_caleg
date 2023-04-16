import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

const ivSize = 16;

final rng = Random();

String formatBytesAsHexString(Uint8List bytes) {
  var result = StringBuffer();
  for( var i=0 ; i<bytes.lengthInBytes ; i++ ) {
    var part = bytes[i];
    result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
  }
  return result.toString();
}

Uint8List createUint8ListFromHexString(String hex) {
  var result = Uint8List(hex.length~/2);
  for( var i=0 ; i<hex.length ; i+=2 ) {
    var num = hex.substring(i, i+2);
    var byte = int.parse( num, radix: 16 );
    result[i~/2] = byte;
  }
  return result;
}

Uint8List createUint8ListFromString( String s ) {
  var ret = Uint8List(s.length);
  for( var i=0 ; i<s.length ; i++ ) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List _processBlocks( BlockCipher cipher, Uint8List inp ) {
  var out = Uint8List(inp.lengthInBytes);
  for( var offset=0 ; offset<inp.lengthInBytes ; ) {
    var len = cipher.processBlock( inp, offset, out, offset );
    offset += len;
  }
  return out;
}

String encryptOnboardingJson(String jsonOnboarding, String key) {
  if (jsonOnboarding == '') return '';

  Digest digestSha256 = SHA256Digest();
  final keySha256 = digestSha256.process(createUint8ListFromString(key));

  final stringBytes = utf8.encode(jsonOnboarding);
  final gzipBytes = GZipCodec().encode(stringBytes);
  final inputData = Uint8List.fromList(gzipBytes);
  final outputData = _encryptRawAesCbc(inputData, keySha256);
  final outputBase64 = base64.encode(outputData);
  return outputBase64;
}
String decryptOnboardingJson(String jsonOnboarding, String key) {
  if (jsonOnboarding == '') return '';

  Digest digestSha256 = SHA256Digest();
  final keySha256 = digestSha256.process(createUint8ListFromString(key));

  final inputBase64 = base64.decode(jsonOnboarding);
  final decryptedGzip = _decryptRawAesCbc(inputBase64, keySha256);
  final decryptedPlain = GZipCodec().decode(decryptedGzip);
  final plain = String.fromCharCodes(decryptedPlain);
  return plain;
}

String encryptAesCbcWithSha256ToHexa(String input, String key) {
  if (input == '') return '';

  Digest digestSha256 = SHA256Digest();
  final keySha256 = digestSha256.process(createUint8ListFromString(key));

  final byteInputOri = createUint8ListFromString(input);
  final outputWithIv = _encryptRawAesCbc(byteInputOri, keySha256);

  var encHexa = formatBytesAsHexString(outputWithIv);
  return encHexa;
}

Uint8List _encryptRawAesCbc(Uint8List byteInput, Uint8List byteKey) {
  BlockCipher cipher = CBCBlockCipher(AESEngine());

  int inputLen = byteInput.lengthInBytes + (cipher.blockSize - (byteInput.lengthInBytes % cipher.blockSize));
//  debugPrint('[CIPHER] input byte: $byteInputOri, input length ${byteInputOri.lengthInBytes}, input padded $inputLen');

  // padding
  Padding padding = PKCS7Padding();
  padding.init();
  var padInput = Uint8List(inputLen)..setAll(0, byteInput);
//  debugPrint('[CIPHER] padInput $padInput');
  /*var padLength =*/ padding.addPadding(padInput, byteInput.lengthInBytes);
//  debugPrint('[CIPHER] padded input byte: $padInput, padded $padLength');

  // generate IV
  Uint8List iv = Uint8List(ivSize);
  for (var i = 0; i < ivSize; i++) {
    iv[i] = rng.nextInt(256);
  }

  KeyParameter params = KeyParameter(byteKey);
  var paramsWithIv = ParametersWithIV(params, iv);

  cipher.init(true, paramsWithIv);
  var byteOutput = _processBlocks(cipher, padInput);
//  debugPrint('[CIPHER] enc byte: $byteOutput');

  // combine IV and encrypted
  var outputWithIv = Uint8List(byteOutput.length + ivSize);
  for (var i = 0; i < ivSize; i++) {
    outputWithIv[i] = iv[i];
  }
  for (var i = 0; i < byteOutput.lengthInBytes; i++) {
    outputWithIv[ivSize + i] = byteOutput[i];
  }
  return outputWithIv;
}

String decryptAesCbcWithSha256FromHexa(String input, String key) {
  if (input == '') return '';

  Digest digestSha256 = SHA256Digest();
  var keySha256 = digestSha256.process(createUint8ListFromString(key));

  var byteInput = createUint8ListFromHexString(input);

  var unpadOutput = _decryptRawAesCbc(byteInput, keySha256);
  var decString = String.fromCharCodes(unpadOutput);
  return decString;
}

Uint8List _decryptRawAesCbc(Uint8List byteInputWithIv, Uint8List byteKey) {
  // extract iv
  Uint8List iv = Uint8List(ivSize);
  var listIv = byteInputWithIv.take(ivSize);
  int idx = 0;
  for (var i in listIv) {
    iv[idx++] = i;
  }

  // extract byteInput
  Uint8List inputNoIv = Uint8List(byteInputWithIv.lengthInBytes - ivSize);
  var listInput =  byteInputWithIv.skip(ivSize);
  idx = 0;
  for (var i in listInput) {
    inputNoIv[idx++] = i;
  }

//  debugPrint('[DECIPHER] enc byte $byteInput');
  BlockCipher cipher = CBCBlockCipher(AESEngine());
  KeyParameter params = KeyParameter(byteKey);
  var paramsWithIv = ParametersWithIV(params, iv);

  cipher.init(false, paramsWithIv);
  var byteOutput = _processBlocks(cipher, inputNoIv);
  // unpad
  Padding padding = PKCS7Padding();
  padding.init();
  var padLength = padding.padCount(byteOutput);
  var unpadOutput = Uint8List.fromList(byteOutput.sublist(0, byteOutput.lengthInBytes - padLength));
  return unpadOutput;
}