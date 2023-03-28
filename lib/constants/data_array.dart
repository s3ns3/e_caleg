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
  };

}