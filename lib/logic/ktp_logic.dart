import 'package:e_caleg/vo/content_input_vo.dart';

class KtpLogic {
  ContentInputVO nik =
      ContentInputVO(label: 'NIK', inputType: ContentInputType.text);
  ContentInputVO name =
      ContentInputVO(label: 'Nama', inputType: ContentInputType.text);
  ContentInputVO birthPlace =
      ContentInputVO(label: 'Tempat Lahir', inputType: ContentInputType.text);
  ContentInputVO birthDate =
      ContentInputVO(label: 'Tanggal Lahir', inputType: ContentInputType.date);
  ContentInputVO address =
      ContentInputVO(label: 'Alamat', inputType: ContentInputType.text);
  ContentInputVO religion =
      ContentInputVO(label: 'Agama', inputType: ContentInputType.text);
  ContentInputVO maritalStatus = ContentInputVO(
      label: 'Status Perkawinan', inputType: ContentInputType.text);
  ContentInputVO job =
      ContentInputVO(label: 'Pekerjaan', inputType: ContentInputType.text);
  ContentInputVO citizenship = ContentInputVO(
      label: 'Kewarganegaraan', inputType: ContentInputType.text);
  ContentInputVO gender =
      ContentInputVO(label: 'Jenis Kelamin', inputType: ContentInputType.text);
  ContentInputVO province =
      ContentInputVO(label: 'Provinsi', inputType: ContentInputType.text);
  ContentInputVO city =
      ContentInputVO(label: 'Kota/Kabupaten', inputType: ContentInputType.text);
  ContentInputVO district =
      ContentInputVO(label: 'Kelurahan', inputType: ContentInputType.text);
  ContentInputVO ward =
      ContentInputVO(label: 'Kecamatan', inputType: ContentInputType.text);
  ContentInputVO rtrw =
      ContentInputVO(label: 'RT/RW', inputType: ContentInputType.text);
  ContentInputVO referalCode = ContentInputVO(
      label: 'Masukkan Kode Registrasi', inputType: ContentInputType.text);
}
