import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/logic/form_result_logic.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../vo/content_input_vo.dart';
import '../base_upload_screen.dart';

class FormResultSubscreen extends BaseUploadScreen {
  static const id = 'RegPreparationSubscreen';
  final String title;
  final RecognizedText recognizedText;

  final FormResultLogic ocrLogic = FormResultLogic();
  FormResultSubscreen({Key? key, required this.title, required this.recognizedText})
      : super(
      key: key,
      onBack: () {
        // NavigationService.get()
        //     .pushAndRemoveUntilHome(AccountGoalScreen());
      });

  @override
  String getRegInfo() {
    return 'Upload C1 DPRRI';
  }

  // @override
  // int getPageIndex() {
  //   return index;
  // }
  //
  // @override
  // int setIndex() {
  //   return index;
  // }

  int index = 16;

  @override
  Widget buildSubScreen(BuildContext context, RefreshScreenCubit bloc) {
    ocrLogic.parseRecognizedText(recognizedText);
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListView(
        children: [
          AppsInput(
            inputVO: ocrLogic.inputCalegName1,
          ),
          AppsInput(
            inputVO: ocrLogic.inputCalegVote1,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: ocrLogic.inputCalegName2,
          ),
          AppsInput(
            inputVO: ocrLogic.inputCalegVote2,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: ocrLogic.inputCalegName3,
          ),
          AppsInput(
            inputVO: ocrLogic.inputCalegVote3,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: ocrLogic.inputCalegName4,
          ),
          AppsInput(
            inputVO: ocrLogic.inputCalegVote4,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: ocrLogic.inputCalegName5,
          ),
          AppsInput(
            inputVO: ocrLogic.inputCalegVote5,
          ),
        ],
      ),
    );
  }
}