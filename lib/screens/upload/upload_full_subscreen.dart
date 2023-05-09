import 'dart:math';

import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/logic/upload_logic.dart';
import 'package:e_caleg/screens/base_upload_screen.dart';
import 'package:e_caleg/screens/upload/form_result_subscreen.dart';
import 'package:e_caleg/screens/upload/image_cropper_page.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:e_caleg/widgets/apps_display_photo.dart';
import 'package:e_caleg/widgets/apps_error_dialog.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:e_caleg/widgets/apps_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class UploadFullSubScreen extends BaseUploadScreen {
  static const id = 'UploadFullSubScreen';

  final UploadDocumentLogic logic;
  UploadFullSubScreen({Key? key, required this.logic})
      : super(key: key, onBack: () {}, logic: logic);

  @override
  String getRegInfo() {
    return logic.typeCaleg.namaTypeCaleg!;
  }

  @override
  Widget buildSubScreen(BuildContext context, RefreshScreenCubit bloc) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: _displayBodyContent(context));
  }

  Widget _displayBodyContent(BuildContext context) {
    return BlocProvider<RefreshScreenCubit>(
        create: (context) => bloc,
        child: BlocBuilder<RefreshScreenCubit, bool>(builder: (context, state) {
          return Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  logic.pathPhoto != null
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: logic.index != 0
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child:inputText(context,
                                                logic.inputPartaiPoint,.7)),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DisplayPhoto(
                                                pathImage: logic.pathPhoto),
                                            const SizedBox(width: 5.0),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children:
                                                  logic.listInput.map((data) {
                                                return inputText(
                                                    context, data, .25);
                                              }).toList(),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          DisplayPhoto(
                                              pathImage: logic.pathPhoto,
                                              width: .95),
                                          const SizedBox(height: 5.0),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children:
                                                logic.listInput.map((data) {
                                              return inputText(
                                                  context, data, .95);
                                            }).toList(),
                                          )
                                        ])))
                      : Container(),
                  AppsGradientButton(
                    label: logic.pathPhoto != null
                        ? 'Ambil Ulang Foto'.toUpperCase()
                        : 'Ambil Foto'.toUpperCase(),
                    radius: 15.0,
                    fontSize: kFontSizeXLarge,
                    onPressed: () {
                      logic.resetData();
                      if (logic.index ==
                          logic.documentResponse.listDokumen!.length) {
                        bloc.refreshScreen();
                      } else {
                        _takePhoto(context);
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  logic.pathPhoto != null
                      ? AppsGradientButton(
                          label: 'LANJUT',
                          radius: 15.0,
                          fontSize: kFontSizeXLarge,
                          onPressed: () async {
                            //request hit upload
                            var pd = AppsProgressDialog(
                                context,
                                'Memproses Upload Data',
                                logic.uploadDocument());

                            ServiceResponseVO res = await pd.show();
                            if (res.rc == rcSuccess) {
                              bloc.refreshScreen();
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

  Container inputText(BuildContext context, ContentInputVO vo, double width) {
    TextEditingController _textCtrl = TextEditingController();
    _textCtrl.text = vo.inputValue;
    return Container(
        margin: const EdgeInsets.only(top: 3.0, bottom: 5.0),
        width: MediaQuery.of(context).size.width * width,
        child: TextField(
          controller: _textCtrl,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
              color: Colors.black,
              fontSize: kFontSizeMedium,
              fontWeight: FontWeight.w500),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            vo.inputValue = value;
          },
          decoration: InputDecoration(
            isDense: true,
            label: Text(vo.label!),
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
      imageCropperView(respVO.msg, logic, context).then((value) async {
        await logic.parseRecognizedText();
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
      logic: logic,
    ));
  }
}
