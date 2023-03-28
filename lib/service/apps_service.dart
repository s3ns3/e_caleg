import 'package:e_caleg/constants/data_array.dart';
import 'package:e_caleg/vo/selection_item.dart';

class AppsService {
  static const id = 'OnboardingDataService';

  static final AppsService _instance = AppsService._();

  static AppsService get() => _instance;

  AppsService._();

  Map<int, List<GeneralSelectionItem>> get _mapGeneralData => DataArray.get().mapGeneralSelection;

  List<GeneralSelectionItem> findGeneralSelectionFor(int lookupCat) {
    List<GeneralSelectionItem> list = _mapGeneralData[lookupCat]??[];
    return list;
  }
}