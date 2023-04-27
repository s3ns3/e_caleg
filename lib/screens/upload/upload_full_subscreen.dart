import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/logic/upload_logic.dart';
import 'package:e_caleg/screens/base_upload_screen.dart';
import 'package:e_caleg/screens/upload/form_result_subscreen.dart';
import 'package:e_caleg/screens/upload/image_cropper_page.dart';
import 'package:e_caleg/service/apps_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/vo/document_vo.dart';
import 'package:e_caleg/vo/selection_item.dart';
import 'package:e_caleg/widgets/apps_display_photo.dart';
import 'package:e_caleg/widgets/apps_error_dialog.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/navigation_service.dart';

class UploadFullSubscreen extends BaseUploadScreen {
  static const id = 'RegPreparationSubscreen';
  final String title;
  UploadFullSubscreen({Key? key, required this.title})
      : super(key: key, onBack: () {});

  final UploadDocumentLogic logic = UploadDocumentLogic();
  @override
  String getRegInfo() {
    return title;
  }

  @override
  int getPageIndex() {
    return index;
  }

  @override
  int setIndex() {
    return index;
  }

  int index = 0;
  @override
  Widget buildSubScreen(BuildContext context, RefreshScreenCubit bloc) {
    return LoadingWidget(
      futureLogic: logic.initLogic,
      child: _displayBodyContent(context),
    );
    // return _displayBodyContent(context);
  }

  Widget _displayBodyContent(BuildContext context) {
    return BlocProvider<RefreshScreenCubit>(
        create: (context) => bloc,
        child: BlocBuilder<RefreshScreenCubit, bool>(builder: (context, state) {
          debugPrint('documentVO : ${logic.documentVO}');
          return Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Text(
                    logic.documentVO[index]
                        .partaiName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: kFontSizeXLarge),
                  ),
                  const SizedBox(height: 10.0),
                  logic.pathPhoto != null
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DisplayPhoto(pathImage: logic.pathPhoto),
                                  const SizedBox(width: 5.0),
                                  index != 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: logic.documentVO[index].listCaleg!.map((data) {
                                            return inputText(context, data);
                                          }).toList(),
                                        )
                                      : Container()
                                ],
                              )))
                      : Container(),
                  AppsGradientButton(
                    label: logic.pathPhoto != null
                        ? 'Ambil Ulang Foto'
                        : 'Ambil Foto',
                    radius: 15.0,
                    fontSize: kFontSizeXLarge,
                    onPressed: () {
                      logic.resetData();
                      if (index == kJumlahPartai) {
                        bloc.refreshScreen();
                      } else {
                        _takePhoto(context);
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  logic.pathPhoto != null
                      ? AppsGradientButton(
                          label: 'Selanjutnya',
                          radius: 15.0,
                          fontSize: kFontSizeXLarge,
                          onPressed: () {
                            if (index != 16) {
                              logic.resetData();
                              index = index + 1;
                              setIndex();
                              bloc.refreshScreen();
                            } else {
                              _readFromPhoto(context);
                            }
                          },
                        )
                      : Container()
                ],
              )),
            ],
          );
        }));
  }

  Container inputText(BuildContext context, CalegVO data) {
    return Container(
        margin: const EdgeInsets.only(top: 3.0, bottom: 5.0),
        width: MediaQuery.of(context).size.width * .25,
        child: TextField(
          textInputAction: TextInputAction.next,
          style: const TextStyle(
              color: Colors.black,
              fontSize: kFontSizeMedium,
              fontWeight: FontWeight.w500),
          keyboardType: TextInputType.number,
          onChanged: (value) {},
          decoration: InputDecoration(
            isDense: true,
            label: Text('${data.calegId}. ${data.calegName!.toUpperCase()}'),
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: kFontSizeMedium),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
            labelStyle: const TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontSize: kFontSizeXSmall),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ));
  }

  void _takePhoto(BuildContext context) async {
    final respVO = await logic.processTakePhoto();
    if (respVO.rc == rcSuccess) {
      imageCropperView(respVO.msg, logic, context).then((value) {
        if (logic.pathPhoto != '') {
          bloc.refreshScreen();
        }
      });
    } else {
      showAppsErrorDialog(context, respVO.msg);
    }
  }

  void _readFromPhoto(BuildContext context) async {
    final result = await logic.recognizeTextFromPhoto();
    NavigationService.get().push(FormResultSubscreen(
      title: 'Hasil Perhitungan Suara',
      recognizedText: result,
    ));
  }
}
