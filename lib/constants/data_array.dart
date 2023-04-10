import 'package:e_caleg/vo/selection_item.dart';
import 'package:e_caleg/constants/apps_constant.dart';
class DataArray {

  static final DataArray _instance = new DataArray();

  static DataArray get() => _instance;

  final Map<int, List<GeneralSelectionItem>> mapGeneralSelection = {
    kSelectionItemLoginType: [
      GeneralSelectionItem(id: '1', label: 'Caleg'),
      GeneralSelectionItem(id: '2', label: 'Timses'),
      GeneralSelectionItem(id: '3', label: 'Saksi'),
    ],
    kSelectionItemPartai:[
      GeneralSelectionItem(id: '1', label: 'Partai Kebangkitan Bangsa'),
      GeneralSelectionItem(id: '2', label: 'Partai Gerakan Indonesia Raya'),
      GeneralSelectionItem(id: '3', label: 'Partai Demokrasi Indonesia Perjuangan'),
      GeneralSelectionItem(id: '4', label: 'Partai Golkar'),
      GeneralSelectionItem(id: '5', label: 'Partai Nasdem'),
      GeneralSelectionItem(id: '6', label: 'Partai Buruh'),
      GeneralSelectionItem(id: '7', label: 'Partai Gelombang Rakyat Indonesia'),
      GeneralSelectionItem(id: '8', label: 'Partai Keadilan Sejahtera'),
      GeneralSelectionItem(id: '9', label: 'Partai Kebangkitan Nusantara'),
      GeneralSelectionItem(id: '10', label: 'Partai Hati Nurani Rakyat'),
      GeneralSelectionItem(id: '11', label: 'Partai Garda Perubahan Indonesia'),
      GeneralSelectionItem(id: '12', label: 'Partai Amanat Nasional'),
      GeneralSelectionItem(id: '13', label: 'Partai Bulan Bintang'),
      GeneralSelectionItem(id: '14', label: 'Partai Demokrat'),
      GeneralSelectionItem(id: '15', label: 'Partai Solidaritas Indonesia'),
      GeneralSelectionItem(id: '16', label: 'Partai Perindo'),
      GeneralSelectionItem(id: '17', label: 'Partai Persatuan Pembangunan'),
    ],
  };

}