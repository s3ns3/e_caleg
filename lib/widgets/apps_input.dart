import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/utils/debouncer_util.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:e_caleg/widgets/apps_input_password.dart';
import 'package:e_caleg/widgets/ensure_visible_when_focused.dart';
import 'package:e_caleg/widgets/search_combobox_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppsInput extends StatefulWidget {
  final ContentInputVO inputVO;
  final Function(String value)? onSubmitted;

  const AppsInput({Key? key, required this.inputVO, this.onSubmitted})
      : super(key: key);

  @override
  State createState() => AppsInputState();
}

class AppsInputState extends State<AppsInput> {
  static const id = 'AppsInputState';

  final _textController = TextEditingController();
  final _debouncer = DebouncerUtil();
  String _selected = '0';
  String? hint;

  var _focusNode;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    if (widget.inputVO.inputType == ContentInputType.numeric ||
        widget.inputVO.inputType == ContentInputType.numericPhoneNo ||
        widget.inputVO.inputType == ContentInputType.money) {
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inputVO.inputType == ContentInputType.list) {
      hint = '${widget.inputVO.label}';
      return SearchComboboxV2(
        inputVO: widget.inputVO,
        onSubmitted: widget.onSubmitted,
      );
    } else if (widget.inputVO.inputType == ContentInputType.password) {
      return AppsPassword(
        inputVO: widget.inputVO,
        onSubmitted: widget.onSubmitted,
      );
    } else if (widget.inputVO.inputType == ContentInputType.date) {
      hint = '${widget.inputVO.label}';
      return _displayInputDate(context);
      // } else if (widget.inputVO.inputType == ContentInputType.numericPhoneNo) {
      //   hint = widget.inputVO.isLabel
      //       ? 'Masukkan ${widget.inputVO.label}'
      //       : widget.inputVO.label;
      //   return _displayInputText(context);
    } else if (widget.inputVO.inputType == ContentInputType.money) {
      hint = widget.inputVO.isLabel
          ? '${widget.inputVO.label}'
          : widget.inputVO.label;
      return Container();
    } else if (widget.inputVO.inputType == ContentInputType.search) {
      hint = widget.inputVO.isLabel
          ? '${widget.inputVO.label}'
          : widget.inputVO.label;
      return _displayInputSearch(context);
    } else if (widget.inputVO.inputType == ContentInputType.radioButton) {
      return _displayRadioButton(context);
    } else if (widget.inputVO.inputType == ContentInputType.radioButtonList) {
      return _displayRadioButtonList(context);
    } else if (widget.inputVO.inputType ==
        ContentInputType.radioButtonHorizontal) {
      debugPrint('selected $_selected');
      _selected = widget.inputVO.inputValue;
      return _displayRadioButtonHorizontal(context);
    } else if (widget.inputVO.inputType == ContentInputType.checkBox) {
      return _displayCheckBox(context);
    } else {
      hint = widget.inputVO.isLabel
          ? '${widget.inputVO.label}'
          : widget.inputVO.label;
      return EnsureVisibleWhenFocused(
          focusNode: _focusNode,
          child: _displayInputText(context)
      );
    }
  }

  Widget _displayCheckBox(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
                width: 24.0,
                height: 24.0,
                child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                  value: widget.inputVO.valueCheckBox,
                  onChanged: (bool? value) {
                    debugPrint('masuk ck');
                    // if (widget.onSubmitted != null) {
                    //   String valueString = kValueFalse;
                    //   if (value!) {
                    //     valueString = kValueTrue;
                    //   } else {
                    //     valueString = kValueFalse;
                    //   }
                    //   widget.onSubmitted!(valueString);
                    //   widget.inputVO.valueCheckBox = value;
                    // }
                  },
                )),
            Expanded(
              child: Text(
                widget.inputVO.label!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black, fontSize: kFontSizeMedium),
              ),
            )
          ],
        ));
  }

  Widget _displayRadioButton(BuildContext context) {
    debugPrint('group value ${widget.inputVO.groupValue}');
    return Container(
      margin: EdgeInsets.only(top: widget.inputVO.color==Colors.transparent?0:5.0),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.white30,
          border: Border.all(width: 1.0, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Radio<String>(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: widget.inputVO.inputValue,
            groupValue: widget.inputVO.groupValue,
            onChanged: (String? value) {
              _debouncer(() {
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(value!);
                  debugPrint('masuk sini $value');
                }
              });
            },
          ),
          Text(widget.inputVO.label!, style: const TextStyle()),
        ],
      ),
    );
  }

  Widget _displayRadioButtonHorizontal(BuildContext context) {
    debugPrint('group value ${widget.inputVO.groupValue}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: widget.inputVO.color==Colors.transparent?0: 5),
            child: Row(
              children: [
                Text(widget.inputVO.label!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: kFontSizeSmall,
                        fontWeight: FontWeight.w500)),
                widget.inputVO.isMandatory == true
                    ? const Text("*",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: kFontSizeSmall,
                            fontWeight: FontWeight.w500))
                    : Container()
              ],
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.inputVO.selections.map((data) {
              return InkWell(
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(top: widget.inputVO.color==Colors.transparent?0:5.0),
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * .43,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        border:
                            Border.all(width: 1.0, color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Theme(
                        data:
                            ThemeData(unselectedWidgetColor: Colors.blue[300]!),
                        child: Row(
                          children: [
                            Radio<String>(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: data.getId(),
                              groupValue: _selected,
                              onChanged: (String? value) {
                                setState(() {
                                  _selected = data.getId().toString();
                                  widget.inputVO.inputValue = _selected;
                                });
                              },
                            ),
                            Text(data.getLabel(),
                                style: const TextStyle()),
                          ],
                        )),
                  ),
                  onTap: () {
                    setState(() {
                      _selected = data.getId().toString();
                      widget.inputVO.inputValue = _selected;
                    });
                  });
            }).toList())
      ],
    );
  }

  Widget _displayRadioButtonList(BuildContext context) {
    return Column(
      children: widget.inputVO.selections.map((data) {
        return InkWell(
          highlightColor: Colors.white,
          splashColor: Colors.white,
          child: Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: Colors.grey[300], borderRadius: BorderRadius.circular(8.0)),
              child: Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFC7DDFF)),
                  child: Row(
                    children: [
                      Radio<String>(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue),
                        activeColor: Colors.blue,
                        value: data.getId(),
                        groupValue: _selected,
                        onChanged: (value) {
                          setState(() {
                            _selected = value.toString();
                            widget.inputVO.inputValue = _selected;
                          });
                        },
                      ),
                      Text(data.getLabel(), style: const TextStyle()),
                    ],
                  ))),
          onTap: () {
            setState(() {
              _selected = data.getId().toString();
              widget.inputVO.inputValue = _selected;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _displayInputText(BuildContext context) {
    _textController.text = widget.inputVO.inputValue;
    //for cursor position end of text
    _textController.selection =
        TextSelection.collapsed(offset: _textController.text.length);
    bool isPassword = false;

    TextInputType? inputType;
    List<TextInputFormatter> inputFormat = <TextInputFormatter>[];
    if (widget.inputVO.inputType == ContentInputType.numeric) {
      inputFormat = <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ];
    }

    if (widget.inputVO.inputType == ContentInputType.numeric) {
      inputType = TextInputType.number;
    } else if (widget.inputVO.inputType == ContentInputType.multiline) {
      inputType = TextInputType.multiline;
    } else if (widget.inputVO.inputType == ContentInputType.numericPhoneNo) {
      inputType = TextInputType.phone;
    } else if (widget.inputVO.inputType == ContentInputType.email) {
      inputType = TextInputType.emailAddress;
    }
    TextInputAction? inputAction;
    if (widget.inputVO.inputType != ContentInputType.multiline ||
        widget.inputVO.inputType == ContentInputType.numeric) {
      inputAction =
          widget.inputVO.hasNext ? TextInputAction.next : TextInputAction.done;
    }

    if (widget.inputVO.inputType == ContentInputType.password) {
      isPassword = true;
    }

    Widget? prefixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      prefixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.prefixAssetName!,
            width: 25.0, //72.0,
            fit: BoxFit.contain,
          ));
    }
    Widget? suffixIcon;
    if (widget.inputVO.suffixAssetName != null) {
      suffixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.suffixAssetName!,
            width: 5.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.grey,
          ));
    }
    return Container(
        padding: EdgeInsets.only(top: widget.inputVO.color==Colors.transparent?0:5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.inputVO.isLabel
                ? Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      children: [
                        Text(widget.inputVO.label!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: kFontSizeSmall,
                                fontWeight: FontWeight.w500)),
                        widget.inputVO.isMandatory == true
                            ? Text("*",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: kFontSizeSmall,
                                    fontWeight: FontWeight.w500))
                            : Container()
                      ],
                    ))
                : Container(),
            TextField(
              enabled: widget.inputVO.isEnable,
              focusNode: _focusNode,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: kFontSizeMedium,
                  fontWeight: FontWeight.w500),
              maxLines: widget.inputVO.inputType == ContentInputType.multiline
                  ? 4
                  : 1,
              keyboardType: inputType, //TextInputType.text,
              controller: _textController,
              textInputAction: inputAction,
              obscureText: isPassword,
              autofocus: widget.inputVO.autoFocus,
              maxLength: widget.inputVO.maxLength,
              inputFormatters: inputFormat,
              decoration: inputDecoration(prefixIcon, suffixIcon),
              onChanged: (value) {
                debugPrint("onchange $value");
                widget.inputVO.inputValue = value;
                _debouncer(() {
                  if (widget.onSubmitted != null) {
                    widget.onSubmitted!(value);
                  }
                });
              },
              // onSubmitted: widget.onSubmitted
            )
          ],
        ));
  }

  // Widget _displayInputMoney(BuildContext context) {
  //   // based on https://stackoverflow.com/questions/51127241/how-do-you-change-the-value-inside-of-a-textfield-flutter?rq=1
  //   // String moneyValue = CommonUtil.displayTextMoney(widget.inputVO.inputValue);
  //   _textController.value = TextEditingValue(
  //     text: moneyValue,
  //     selection: TextSelection.fromPosition(
  //       TextPosition(offset: moneyValue.length),
  //     ),
  //   );
  //
  //   TextInputAction? inputAction;
  //   if (widget.inputVO.inputType != ContentInputType.multiline ||
  //       widget.inputVO.inputType == ContentInputType.numeric) {
  //     inputAction =
  //         widget.inputVO.hasNext ? TextInputAction.next : TextInputAction.done;
  //   }
  //
  //   Widget? prefixIcon;
  //   if (widget.inputVO.prefixAssetName != null) {
  //     prefixIcon = Padding(
  //         padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
  //         child: Image.asset(
  //           widget.inputVO.prefixAssetName!,
  //           width: 5.0, //72.0,
  //           fit: BoxFit.contain,
  //           color: Colors.blue,
  //         ));
  //   }
  //   Widget? suffixIcon;
  //   if (widget.inputVO.suffixAssetName != null) {
  //     suffixIcon = Padding(
  //         padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
  //         child: Image.asset(
  //           widget.inputVO.suffixAssetName!,
  //           width: 5.0, //72.0,
  //           fit: BoxFit.contain,
  //           color: Colors.blue,
  //         ));
  //   }
  //   return Container(
  //       padding: const EdgeInsets.only(top: 5),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         widget.inputVO.isLabel
  //             ? Padding(
  //                 padding: EdgeInsets.only(bottom: 3.0),
  //                 child: Row(
  //                   children: [
  //                     Text(widget.inputVO.label!,
  //                         style: const TextStyle(
  //                             color: Colors.black,
  //                             fontSize: kFontSizeSmall,
  //                             fontWeight: FontWeight.w500)),
  //                     widget.inputVO.isMandatory == true
  //                         ? Text("*",
  //                             style: const TextStyle(
  //                                 color: Colors.red,
  //                                 fontSize: kFontSizeSmall,
  //                                 fontWeight: FontWeight.w500))
  //                         : Container()
  //                   ],
  //                 ))
  //             : Container(),
  //         TextField(
  //           controller: _textController,
  //           style: const TextStyle(
  //               color: Colors.black,
  //               fontSize: kFontSizeMedium,
  //               fontWeight: FontWeight.w500),
  //           maxLines:
  //               widget.inputVO.inputType == ContentInputType.multiline ? 4 : 1,
  //           keyboardType: TextInputType.number,
  //           textInputAction: inputAction,
  //           obscureText: widget.inputVO.inputType == ContentInputType.password,
  //           decoration: inputDecoration(prefixIcon, suffixIcon),
  //           onChanged: (value) {
  //             // debugPrint("onchange $value");
  //             widget.inputVO.inputValue = CommonUtil.parseTextMoney(value);
  //             String moneyValue =
  //                 CommonUtil.displayTextMoney(widget.inputVO.inputValue);
  //             _textController.value = TextEditingValue(
  //               text: moneyValue,
  //               selection: TextSelection.fromPosition(
  //                 TextPosition(offset: moneyValue.length),
  //               ),
  //             );
  //
  //             _debouncer(() {
  //               if (widget.onSubmitted != null) {
  //                 widget.onSubmitted!(value);
  //               }
  //             });
  //           },
  //           //onSubmitted: widget.onSubmitted
  //         )
  //       ]));
  // }

  Widget _displayInputTextNotController(BuildContext context) {
    TextInputType inputType = TextInputType.phone;
    TextInputAction inputAction =
        widget.inputVO.hasNext ? TextInputAction.next : TextInputAction.done;

    Widget? prefixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      prefixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.prefixAssetName!,
            width: 5.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.blue,
          ));
    }
    Widget? suffixIcon;
    if (widget.inputVO.suffixAssetName != null) {
      suffixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.suffixAssetName!,
            width: 5.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.blue,
          ));
    }
    return Container(
        padding: const EdgeInsets.only(top: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.inputVO.isLabel
              ? Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                  child: Row(
                    children: [
                      Text(widget.inputVO.label!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: kFontSizeSmall,
                              fontWeight: FontWeight.w500)),
                      widget.inputVO.isMandatory == true
                          ? Text("*",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: kFontSizeSmall,
                                  fontWeight: FontWeight.w500))
                          : Container()
                    ],
                  ))
              : Container(),
          TextField(
            style: const TextStyle(
                color: Colors.black,
                fontSize: kFontSizeMedium,
                fontWeight: FontWeight.w500),
            maxLines:
                widget.inputVO.inputType == ContentInputType.multiline ? 4 : 1,
            keyboardType: inputType,
            controller: _textController,
            textInputAction: inputAction,
            obscureText: false,
            decoration: inputDecoration(prefixIcon, suffixIcon),
            onChanged: (value) {
              // debugPrint("onchange $value");
              widget.inputVO.inputValue = value;
              _debouncer(() {
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(value);
                }
              });
            },
            //onSubmitted: widget.onSubmitted
          )
        ]));
  }

  Widget _displayInputDate(BuildContext context) {
    _textController.text = widget.inputVO.inputValue;
    Widget? prefixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      prefixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.prefixAssetName!,
            width: 5.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.white,
          ));
    }
    Widget? suffixIcon = const Padding(
        padding: EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
        child: Icon(
          Icons.date_range,
          color: Colors.black54,
        ));
    return Container(
        padding: const EdgeInsets.only(top: 5),
        // color: kColorPrimary,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.inputVO.isLabel
              ? Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                  child: Row(
                    children: [
                      Text(widget.inputVO.label!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: kFontSizeSmall,
                              fontWeight: FontWeight.w500)),
                      widget.inputVO.isMandatory == true
                          ? Text("*",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: kFontSizeSmall,
                                  fontWeight: FontWeight.w500))
                          : Container()
                    ],
                  ))
              : Container(),
          TextField(
            style: const TextStyle(
                color: Colors.black,
                fontSize: kFontSizeMedium,
                fontWeight: FontWeight.w500),
            controller: _textController,
            decoration: inputDecoration(prefixIcon, suffixIcon),
            readOnly: true,
            textInputAction: widget.inputVO.hasNext
                ? TextInputAction.next
                : TextInputAction.done,
            onTap: () async {
              const duration = Duration(days: 100 * 360);
              DateTime initialDate = widget.inputVO.inputDate ?? DateTime.now();
              DateTime firstDate =
                  widget.inputVO.firstDate ?? DateTime.now().subtract(duration);
              DateTime lastDate =
                  widget.inputVO.firstDate ?? DateTime.now().add(duration);

              // final date = await showDatePicker(
              //     context: context,
              //     initialDate: initialDate,
              //     firstDate: DateTime(1950, 8),
              //     lastDate: initialDate);

              final date = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: firstDate,
                  lastDate: lastDate);
              widget.inputVO.inputDate = date;
              debugPrint('setDate : ${widget.inputVO.inputValue}');
              _textController.text = widget.inputVO.inputValue;
            },
            // onSubmitted: widget.onSubmitted
          ),
        ]));
  }

  Widget _displayInputSearch(BuildContext context) {
    _textController.text = widget.inputVO.inputValue;

    TextInputAction? inputAction;
    if (widget.inputVO.inputType != ContentInputType.multiline ||
        widget.inputVO.inputType == ContentInputType.numeric) {
      inputAction =
          widget.inputVO.hasNext ? TextInputAction.next : TextInputAction.done;
    }

    Widget? prefixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      prefixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.prefixAssetName!,
            width: 25.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.grey,
          ));
    }
    Widget? suffixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      suffixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.prefixAssetName!,
            width: 25.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.grey,
          ));
    }

    return Container(
        padding: const EdgeInsets.only(top: 5),
        // color: kColorPrimary,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.inputVO.isLabel
              ? Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                  child: Row(
                    children: [
                      Text(widget.inputVO.label!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: kFontSizeSmall,
                              fontWeight: FontWeight.w500)),
                      widget.inputVO.isMandatory == true
                          ? Text("*",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: kFontSizeSmall,
                                  fontWeight: FontWeight.w500))
                          : Container()
                    ],
                  ))
              : Container(),
          TextField(
            style: const TextStyle(
                color: Colors.black,
                fontSize: kFontSizeMedium,
                fontWeight: FontWeight.w500),
            maxLines:
                widget.inputVO.inputType == ContentInputType.multiline ? 4 : 1,
            keyboardType: TextInputType.text,
            controller: _textController,
            textInputAction: inputAction,
            obscureText: false,
            decoration: inputDecoration(prefixIcon, suffixIcon),
            onChanged: (value) {
              // debugPrint("onchange $value");
              widget.inputVO.inputValue = value;
              _debouncer(() {
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(value);
                }
              });
            },
            //onSubmitted: widget.onSubmitted
          )
        ]));
  }

  InputDecoration inputDecoration(Widget? prefixIcon, Widget? suffixIcon) {
    return InputDecoration(
      filled: true,
      // labelText: widget.inputVO.label,
      fillColor: widget.inputVO.isEnable ? widget.inputVO.color : Colors.grey[200],
      focusColor: widget.inputVO.color,
      isDense: true,
      counterText: "",
      hintText: widget.inputVO.inputType == ContentInputType.date
          ? widget.inputVO.color==Colors.transparent?hint:'mm/DD/yyyy'
          : hint,
      hintStyle: TextStyle(
          color:  widget.inputVO.color==Colors.transparent?Colors.black:Colors.grey,
          fontStyle: FontStyle.normal,
          fontSize: kFontSizeMedium),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      labelStyle: const TextStyle(
          color: Colors.grey,
          fontStyle: FontStyle.normal,
          fontSize: kFontSizeMedium),
      prefixIcon: prefixIcon,
      // set the prefix icon constraints
      prefixIconConstraints: const BoxConstraints(
        minWidth: 25,
        minHeight: 25,
      ),
      suffixIcon: suffixIcon,
      // set the prefix icon constraints
      suffixIconConstraints: const BoxConstraints(
        minWidth: 25,
        minHeight: 25,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.inputVO.color==Colors.transparent?Colors.transparent:Color(0xFFD9D9D9), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.inputVO.color==Colors.transparent?Colors.transparent:Color(0xFFD9D9D9), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.inputVO.color==Colors.transparent?Colors.transparent:Colors.blue, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
