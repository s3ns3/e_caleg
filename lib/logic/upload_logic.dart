import 'dart:io';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/UploadDocumentService.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:e_caleg/vo/document_vo.dart';
import 'package:e_caleg/vo/req_document_vo.dart';
import 'package:e_caleg/vo/selection_item.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:e_caleg/vo/user_data_vo.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class UploadDocumentLogic {
  final inputPartaiPoint = ContentInputVO(
    label: 'SUARA PARTAI',
    inputType: ContentInputType.numeric,
    isMandatory: false,
    hasNext: false,
  );

  String? pathPhoto;
  // indicate that selfie has been taken
  bool _hasTakenPhoto = false;
  bool get hasTakenPhoto => _hasTakenPhoto;
  List<GeneralSelectionItem> listPartai = [];
  late DocumentResponse _documentResponse;
  late TypeCaleg typeCaleg;

  late List<ContentInputVO> listInput = [];
  int index = 0;

  DocumentVO get doc => documentResponse.listDokumen![index];
  DocumentResponse get documentResponse => _documentResponse;

  Future<ServiceResponseVO> initLogic() async {
    ServiceResponseVO responseVO = await UploadDocumentService.get()
        .requestInit(calegTypeId: typeCaleg.typeCalegId!);
    if (responseVO.rc == rcSuccess) {
      _documentResponse = UploadDocumentService.get().documentResponse;
      index = int.parse(_documentResponse.state!);
      if (index >= 1) {
        index = index + 1;
      }
      createFieldInput();
    }

    return responseVO;
  }

  Future<ServiceResponseVO> createFieldInput() async {
    listInput.clear();
    // debugPrint('index :$index');
    List<CalegVO>? listCaleg = _documentResponse.listDokumen![index].listCaleg;
    // debugPrint('listCaleg :${listCaleg.toString()}');
    if (listCaleg != null && listCaleg.isNotEmpty) {
      // debugPrint('masuk sini');
      for (var data in listCaleg) {
        listInput.add(ContentInputVO(
            label: '${data.calegId}. ${data.calegName}',
            paramName: data.calegId));
      }
    }

    return ServiceResponseVO(rcSuccess, '');
  }

  void resetData() {
    _hasTakenPhoto = false;
    pathPhoto = null;
    createFieldInput();
  }

  //submit data
  Future<ServiceResponseVO> uploadDocument() async {
    debugPrint('masuk sini');
    if (pathPhoto == null) {
      return ServiceResponseVO(rcValidationError, 'Harap ambil foto form C1');
    }

    List<ReqCalegVO> reqCalegVO = [];
    for (var inputData in listInput) {
      debugPrint('masuk sini ${inputData.toString()}');
      ReqCalegVO d = ReqCalegVO();
      d.calegId = inputData.paramName;
      d.calegPoint = inputData.inputValue;
      reqCalegVO.add(d);
    }

    ReqDocumentVO reqDocumentVO = ReqDocumentVO(
        partaiId: doc.partaiId,
        typeCalegId: typeCaleg.typeCalegId!,
        suaraPartai: inputPartaiPoint.inputValue,
        listCaleg: reqCalegVO);

    debugPrint('reqDocumentVO ${reqDocumentVO.toJson()}');

    ServiceResponseVO responseVO = await UploadDocumentService.get()
        .requestUploadDocument(
            reqDocumentVO: reqDocumentVO, documentPhoto: File(pathPhoto!));
    if (responseVO.rc == rcSuccess) {
      //reset form after send the data
      index = index + 1;
      resetData();
      return ServiceResponseVO(rcSuccess, '');
    } else {
      return responseVO;
    }
  }

  Future<ServiceResponseVO> processTakePhoto() async {
    _hasTakenPhoto = true;
    debugPrint("selfie");
    final picker = ImagePicker();
    var filePicked = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 2048.0,
        maxHeight: 2048.0,
        preferredCameraDevice: CameraDevice.rear);
    if (filePicked == null) {
      pathPhoto = null;
      return ServiceResponseVO(rcPictureNotTaken, 'Belum mengambil foto');
    }
    File file = File(filePicked.path);
    // ServiceResponseVO respVO = await OnboardingService.get().sendOnboardingSelfie(fileSelfie: fileSelfie);
    // if (respVO.rc != rcSuccess) return respVO;

    // pathPhoto = file.path;
    return ServiceResponseVO(rcSuccess, file.path);
  }

  Future<RecognizedText> recognizeTextFromPhoto() async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    InputImage inputImage = InputImage.fromFilePath(pathPhoto!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    return recognizedText;
  }

  Future parseRecognizedText() async {
    List<CalegVO>? listCaleg = _documentResponse.listDokumen![index].listCaleg;
    String partaiName = _documentResponse.listDokumen![index].partaiName.toLowerCase().replaceAll(' ', '');
    List<TextBlock> calegBlocks = [];
    TextBlock? partaiBlock;
    RecognizedText recognizedText = await recognizeTextFromPhoto();
    for (var block in recognizedText.blocks) {
      String blockText = block.text.toLowerCase().replaceAll(' ', '');
      if(blockText.contains(partaiName)) {
        partaiBlock = block;
        debugPrint("$partaiName - ${block.text}");
      }
      if (listCaleg != null && listCaleg.isNotEmpty) {
        for (var data in listCaleg) {
          String calegName = data.calegName!.toLowerCase().replaceAll(' ', '');
          if (blockText.contains(calegName)) {
            calegBlocks.add(block);
            debugPrint("$calegName - ${block.text}");
          }
        }
      }
    }
    getPartaiPointFromTextBlock(recognizedText.blocks, partaiBlock!);
    getCalegPointFromTextBlock(recognizedText.blocks, calegBlocks);
  }

  void getPartaiPointFromTextBlock(List<TextBlock> blocks, TextBlock partaiBlock) {
    for (var block in blocks) {
      int diff = block.cornerPoints[0].y - partaiBlock.cornerPoints[0].y;
      if (block.text != partaiBlock.text && diff.abs() < 5) {
        inputPartaiPoint.inputValue = block.text;
      }
    }
  }

  void getCalegPointFromTextBlock(
      List<TextBlock> blocks, List<TextBlock> calegBlocks) {
    int i = 0;
    for (var input in listInput) {
      if(i < calegBlocks.length) {
        for (var block in blocks) {
          int diff = block.cornerPoints[0].y - calegBlocks[i].cornerPoints[0].y;
          debugPrint("${block.text} - $diff");
          if (block.text != calegBlocks[i].text && diff.abs() < 20) {
            input.inputValue = block.text;
            debugPrint(input.toString());
          }
        }
      }
      i++;
    }
  }

  Future<ServiceResponseVO> prosesInit() async {
    return await UploadDocumentService.get()
        .requestInit(calegTypeId: typeCaleg.typeCalegId!);
  }
}
