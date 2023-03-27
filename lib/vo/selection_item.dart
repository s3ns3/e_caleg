
abstract class SelectionItem {
  String getId();
  String getLabel();
  String getStatus();
}

class GeneralSelectionItem extends SelectionItem {
  final String id;
  final String label;
  final String status;

  GeneralSelectionItem({required this.id, required this.label, this.status = '1'});

  @override
  String getId() => id;

  @override
  String getLabel() => label;

  @override
  String getStatus() => status;

  @override
  String toString() {
    return 'GeneralSelectionItem{id: $id, label: $label, status: $status}';
  }
}

// class LookupSelectionItem extends SelectionItem {
//   final OnboardingLookupVO lookup;
//
//   LookupSelectionItem(this.lookup);
//
//   @override
//   String getId() => lookup.lookupValue;
//
//   @override
//   String getLabel() => lookup.lookupDesc;
//
//   @override
//   String getStatus() => lookup.lookupDesc;
//
//   @override
//   String toString() {
//     return 'LookupSelectionItem{lookup: $lookup}';
//   }
// }
//
// class OnboardingPostalSelectionItem extends SelectionItem {
//   final OnboardingPostalVO postalVO;
//
//   OnboardingPostalSelectionItem(this.postalVO);
//
//   @override
//   String getId() => postalVO.kodePos;
//
//   @override
//   String getLabel() => '${postalVO.kodePos} - ${postalVO.kelurahan}, ${postalVO.kecamatan}, ${postalVO.kabupaten}';
//
//   @override
//   String getStatus() => '';
//
//   @override
//   String toString() {
//     return 'OnboardingPostalSelectionItem{postalVO: $postalVO}';
//   }
// }