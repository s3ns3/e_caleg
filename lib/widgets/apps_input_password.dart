import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppsPassword extends StatefulWidget {
  final ContentInputVO inputVO;
  final Function(String value)? onSubmitted;

  const AppsPassword({Key? key, required this.inputVO, this.onSubmitted}): super(key: key);

  @override
  State createState() => AppsPasswordState();
}

class AppsPasswordState extends State<AppsPassword> {
  static const id = 'AppsPasswordState';

  final _textController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.text = widget.inputVO.inputValue;
    _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length)
    );

    TextInputAction? inputAction = widget.inputVO.hasNext ?
      TextInputAction.next : TextInputAction.done;

    Widget? prefixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      prefixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 4.0, end: 4.0),
          child: Image.asset(widget.inputVO.prefixAssetName!,
            width: 5.0, //72.0,
            fit: BoxFit.contain,
            color: Colors.grey,
          )
      );
    }

    Widget? suffixIcon;
    suffixIcon = InkWell(
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: Image.asset(
            _obscureText
                ? 'assets/images/icons/ic_close_eye.png'
                :'assets/images/icons/ic_eye.png',
            width: 22,
            height: 22,
            color: Colors.grey,
          )),
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );

    TextInputType inputType = TextInputType.text;
    if (widget.inputVO.inputType == ContentInputType.numeric) {
      inputType = TextInputType.number;
    } else if (widget.inputVO.inputType == ContentInputType.multiline) {
      inputType = TextInputType.multiline;
    }

    return Container(
        padding: const EdgeInsets.only(top: 10,bottom: 10),
        child: TextField(
            style: const TextStyle(
                color: Colors.black,
                fontSize: kFontSizeMedium,
                fontWeight: FontWeight.w500),
            maxLines: 1,
            autofocus: widget.inputVO.autoFocus,
            keyboardType: inputType,
            controller: _textController,
            textInputAction: inputAction,
            maxLength: widget.inputVO.maxLength,
            obscureText: _obscureText,
            decoration: inputDecoration(prefixIcon, suffixIcon),
            onChanged: (value) {
              widget.inputVO.inputValue = value;
            },
            onSubmitted: widget.onSubmitted
        )
    );
  }

  InputDecoration inputDecoration(Widget? prefixIcon, Widget? suffixIcon) {
    return InputDecoration(
      // label: Text(widget.inputVO.label!) ,
      filled: true,
      counterText: "",
      // labelText: widget.inputVO.label,
      fillColor: widget.inputVO.isEnable ? Colors.white : Colors.grey[200],
      focusColor: Colors.white,
      isDense: true,
      hintText:'Masukkan ${widget.inputVO.label}',
      hintStyle: const TextStyle(
          color: Colors.grey,
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
        borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}