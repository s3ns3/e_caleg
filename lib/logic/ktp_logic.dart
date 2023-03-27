import 'package:e_caleg/vo/content_input_vo.dart';

class KtpLogic {
  ContentInputVO nik = ContentInputVO(
      label: 'NIK', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO name = ContentInputVO(
      label: 'Nama', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO birthPlace = ContentInputVO(
      label: 'Tempat Lahir', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO birthDate = ContentInputVO(
      label: 'Tanggal Lahir',
      isEnable: false,
      inputType: ContentInputType.date);
  ContentInputVO address = ContentInputVO(
      label: 'Alamat', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO religion = ContentInputVO(
      label: 'Agama', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO maritalStatus = ContentInputVO(
      label: 'Status Perkawinan',
      isEnable: false,
      inputType: ContentInputType.text);
  ContentInputVO job = ContentInputVO(
      label: 'Pekerjaan', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO citizenship = ContentInputVO(
      label: 'Kewarganegaraan',
      isEnable: false,
      inputType: ContentInputType.text);
  ContentInputVO gender = ContentInputVO(
      label: 'Jenis Kelamin',
      isEnable: false,
      inputType: ContentInputType.text);
  ContentInputVO province = ContentInputVO(
      label: 'Provinsi', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO city = ContentInputVO(
      label: 'Kota/Kabupaten',
      isEnable: false,
      inputType: ContentInputType.text);
  ContentInputVO district = ContentInputVO(
      label: 'Kelurahan', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO ward = ContentInputVO(
      label: 'Kecamatan', isEnable: false, inputType: ContentInputType.text);
  ContentInputVO rtrw = ContentInputVO(
      label: 'RT/RW', isEnable: false, inputType: ContentInputType.text);
}
