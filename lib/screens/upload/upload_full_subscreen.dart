import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/logic/upload_logic.dart';
import 'package:e_caleg/screens/base_upload_screen.dart';
import 'package:e_caleg/service/apps_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_display_photo.dart';
import 'package:e_caleg/widgets/apps_error_dialog.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadFullSubscreen extends BaseUploadScreen {
  static const id = 'RegPreparationSubscreen';
  final String title;
  UploadFullSubscreen({Key? key, required this.title})
      : super(
            key: key,
            onBack: () {
              // NavigationService.get()
              //     .pushAndRemoveUntilHome(AccountGoalScreen());
            });

  final UploadLogic logic = UploadLogic();
  @override
  String getRegInfo() {
    return 'Upload C1 DPRRI';
  }

  @override
  int getPageIndex() {
    return index;
  }

  @override
  int setIndex() {
    return index;
  }

  int index = 1;
  @override
  Widget buildSubScreen(BuildContext context, RefreshScreenCubit bloc) {
    // return LoadingWidget(
    //   futureLogic: logic.initLogic,
    //   child: _displayBodyContent(context),
    // );
    return _displayBodyContent(context);
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
                  Text(
                    AppsService.get()
                        .findGeneralSelectionFor(
                            kSelectionItemPartai)[index - 1]
                        .label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: kFontSizeHeader),
                  ),
                  const SizedBox(height: 10.0),
                  DisplayPhoto(pathImage: logic.pathPhoto),
                  const SizedBox(height: 20.0),
                  AppsGradientButton(
                    label: logic.pathPhoto != null ? 'Ambil Ulang Foto' : 'Ambil Foto',
                    radius: 15.0,
                    fontSize: kFontSizeXLarge,
                    onPressed: () {
                      if (index == kJumlahPartai) {
                        bloc.refreshScreen();
                      } else {
                        _takePhotoSelfie(context);
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
                            logic.resetData();
                            index = index + 1;
                            setIndex();
                            bloc.refreshScreen();
                          },
                        )
                      : Container()
                ],
              )),
            ],
          );
        }));
  }

  void _takePhotoSelfie(BuildContext context) async {
    final respVO = await logic.processTakePhoto();
    if (respVO.rc == rcSuccess) {
      bloc.refreshScreen();
    } else {
      showAppsErrorDialog(context, respVO.msg);
    }
  }
}
