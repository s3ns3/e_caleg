import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/vo/selection_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// numericPhoneNo disable textController,
// because it seems that the field cannot be entered in the first time if using textController
// money will inserts dot for every thousand
enum ContentInputType {
  text,
  email,
  multiline,
  password,
  numeric,
  list,
  listImage,
  date,
  numericPhoneNo,
  money,
  search,
  radioButton,
  radioButtonHorizontal,
  checkBox,
  radioButtonList
}

class ContentInputVO {
  final String? paramName;
  final String? label;
  final String? prefixAssetName; // use Image.asset for prefix
  final String? suffixAssetName;
  final bool hasNext; // flag to indicate action next or done
  final bool isLabel;
  final bool isMandatory;
  final ContentInputType? inputType;
  final bool isEnable;
  final int maxLength;
  final bool autoFocus;
  final Color color;
  // final bool obscureText;
  // final String regex;

  // cannot be final because initialize in init, not in constructor
  final List<SelectionItem> _selections = [];
  List<SelectionItem> get selections => _selections;
  SelectionItem? _selectedItem;
  set selections(List<SelectionItem> list) {
    _selections.clear();
    _selections.addAll(list);
    // clear selectedItem
    selectedItem = null;
  }

  // TextEditingController? _textController; // only applicable if type = list

  String inputValue;
  bool valueCheckBox;
  String groupValue;
  DateTime? _inputDate;
  DateTime? firstDate; // used with inputType.date for firstDate
  DateTime? lastDate; // used with inputType.date for lastDate

  set inputDate(DateTime? date) {
    _inputDate = date;
    if (_inputDate == null) {
      inputValue = '';
    } else {
      inputValue = DateFormat(kFormatDateDisplay).format(_inputDate!);
    }
  }

  DateTime? get inputDate => _inputDate;

  set selectedItem(SelectionItem? selected) {
    inputValue = selected?.getId() ?? '';
    _selectedItem = selected;
    // _textController?.text = selectedItem?.getLabel() ?? '';
  }

  SelectionItem? get selectedItem {
    // for (var item in selections) {
    //   if (item.getId() == inputValue) return item;
    // }
    // return null;
    return _selectedItem;
  }

  void setSelectedItemById(String id) {
    for (var item in selections) {
      if (item.getId() == id) {
        selectedItem = item;
        break;
      }
    }
  }

  // set textController(TextEditingController textEditingController) {
  //   _textController = textEditingController;
  //   _textController?.text = selectedItem?.getLabel() ?? '';
  // }

  ContentInputVO({
    this.paramName,
    this.label,
    this.prefixAssetName,
    this.suffixAssetName,
    this.hasNext = false,
    this.inputType,
    this.isLabel = true,
    this.isMandatory = true,
    this.valueCheckBox = false,
    this.inputValue = '',
    this.isEnable = true,
    this.autoFocus = false,
    this.maxLength = 250,
    this.color = Colors.white,
    this.groupValue = '', //Mandatory if use radiobutton
  });

  @override
  String toString() {
    return 'ContentInputVO{paramName: $paramName'
        ', label: $label'
        ', prefixAssetName: $prefixAssetName'
        ', suffixAssetName: $suffixAssetName'
        ', hasNext: $hasNext'
        ', inputType: $inputType'
        ', inputValue: $inputValue'
        '}';
  }
}
