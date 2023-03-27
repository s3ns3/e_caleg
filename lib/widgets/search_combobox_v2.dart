import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:e_caleg/vo/selection_item.dart';
import 'package:flutter/material.dart';

class SearchComboboxV2 extends StatefulWidget {
  final ContentInputVO inputVO;
  final Function(String value)? onSubmitted;

  const SearchComboboxV2({Key? key, required this.inputVO, this.onSubmitted})
      : super(key: key);

  @override
  State createState() => SearchComboboxV2State();
}

class SearchComboboxV2State extends State<SearchComboboxV2> {
  static const id = 'ListSelectionState';

  final _textController = TextEditingController();
  List<SelectionItem>? listData;
  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget.inputVO.textController = _textController;

    _textController.text = widget.inputVO.selectedItem?.getLabel() ?? '';

    // if(widget.inputVO!.inputValue != '') _textController.text = widget.inputVO!.inputValue;
    Widget? prefixIcon;
    if (widget.inputVO.prefixAssetName != null) {
      prefixIcon = Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Image.asset(
            widget.inputVO.prefixAssetName!,
            width: 5.0, //72.0,
            fit: BoxFit.contain,
            color: const Color(0xFF7CC5E1),
          ));
    }
    return Container(
        padding: EdgeInsets.only(top: widget.inputVO.color == Colors.transparent?0:5, bottom: widget.inputVO.color == Colors.transparent?0:5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        widget.inputVO.isLabel
        ? Padding(
        padding: EdgeInsets.only(bottom: 3.0),
        child: Row(
          children: [
            Text(widget.inputVO.label!,
                style: const TextStyle(
                    fontWeight: FontWeight.w500)),
            widget.inputVO.isMandatory == true
                ? const Text("*",
                style: TextStyle(
                    fontWeight: FontWeight.w500))
                : Container()
          ],
        )):Container(),TextField(
          controller: _textController,
          style: TextStyle(
              color: Colors.black,
              fontSize: kFontSizeMedium),
          decoration: InputDecoration(
            filled: true,
            // labelText: widget.inputVO.label,
            fillColor: widget.inputVO.color,
            focusColor: widget.inputVO.color,
            isDense: true,
            hintText: '${widget.inputVO.label}',
            hintStyle: TextStyle(
                color: widget.inputVO.color==Colors.transparent?Colors.black:Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: kFontSizeMedium),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            labelStyle: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: kFontSizeMedium),
            prefixIcon: prefixIcon,
            // set the prefix icon constraints
            prefixIconConstraints: const BoxConstraints(
              minWidth: 25,
              minHeight: 25,
            ),
            suffixIcon: const Icon(Icons.arrow_drop_down,size: 25,),
            // set the prefix icon constraints
            suffixIconConstraints: const BoxConstraints(
              minWidth: 25,
              minHeight: 25,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.inputVO.color==Colors.transparent?Colors.transparent:Color(0xFFD9D9D9), width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.inputVO.color==Colors.transparent?Colors.transparent:Colors.blue, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          readOnly: true,
          onTap: () {
            debugPrint('[$id] tap on selection');
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return _displayListSelection(context, widget.inputVO);
                });
          },
        )]));
  }

  Widget _displayListSelection(BuildContext context, ContentInputVO inputVO) {
    bool needSearch = (inputVO.selections.length > 15);
    double height = inputVO.selections.length * 60.0; // for items
    height = 55 + height;
    if (needSearch) height = height + 60;
    double maxHeight = MediaQuery.of(context).size.height * 0.9;
    debugPrint('[$id] height $height, maxHeight $maxHeight');
    if (height >= maxHeight) height = maxHeight;
    listData = inputVO.selections;
    List<Widget> widgets = [];

    for (SelectionItem item in listData!) {
      bool selected = (item == inputVO.selectedItem);
      widgets.add(TextButton(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.7)),
            ),
            //color: kTelkomselBackgroundWhite
          ),
          height: 20.0,
          alignment: Alignment.centerLeft,
          child: Text(
            item.getLabel(),
            style: TextStyle(
                color: selected ? Colors.red : Colors.black,
                fontSize: kFontSizeSmall),
            textAlign: TextAlign.left,
          ),
        ),
        onPressed: () {
          _selectItem(context, item);
        },
      ));
    }
    return SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Pilih ${widget.inputVO.label}',
                      style: TextStyle(
                          fontSize: kFontSizeSmall,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    onTap: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            needSearch
                ? Container(
                    height: 40.0,
                    margin: const EdgeInsets.only(
                        top: 20.0, right: 15.0, left: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.fromLTRB(30.0, 7.0, 0.0, 5.0),
                        focusColor: Colors.black,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20.0,
                          color: Colors.black87,
                        ),
                        hintText: 'Cari',
                      ),
                      onChanged: (value) {
                        String filter = _textController.text;
                        listData!.clear();
                        listData!.forEach((data) {
                          if (data.getLabel()
                              .toLowerCase()
                              .contains(filter.toLowerCase()))
                            listData!.add(data);
                        });
                        setState(() {
                        });
                      },
                    ),
                  )
                : Container(),
            Expanded(
                child: ListView.builder(
              itemCount: widgets.length,
              itemBuilder: (context, index) => widgets[index],
            ))
          ],
        ));
  }

  void _selectItem(BuildContext context, SelectionItem? item) {
    if (item != null) {
      debugPrint('[$id] selection $item');
      widget.inputVO.selectedItem = item;
    } else {
      widget.inputVO.selectedItem = null;
    }
    _textController.text = widget.inputVO.selectedItem?.getLabel() ?? '';
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(widget.inputVO.inputValue);
    }

    Navigator.pop(context);
  }
}
