import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/logic/form_result_logic.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../vo/content_input_vo.dart';
import '../base_upload_screen.dart';

class FormInputSubscreen extends BaseUploadScreen {
  static const id = 'FormInputSubscreen';
  final String title;
  final RecognizedText recognizedText;

  FormInputSubscreen({Key? key, required this.title, required this.recognizedText})
      : super(
      key: key,
      onBack: () {
        // NavigationService.get()
        //     .pushAndRemoveUntilHome(AccountGoalScreen());
      });

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

  int index = 16;
  FormResultLogic logic = FormResultLogic();

  @override
  Widget buildSubScreen(BuildContext context, RefreshScreenCubit bloc) {
    logic.parseRecognizedText(recognizedText);
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListView(
        children: [
          AppsInput(
            inputVO: logic.inputCalegName1,
          ),
          AppsInput(
            inputVO: logic.inputCalegVote1,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: logic.inputCalegName2,
          ),
          AppsInput(
            inputVO: logic.inputCalegVote2,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: logic.inputCalegName3,
          ),
          AppsInput(
            inputVO: logic.inputCalegVote3,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: logic.inputCalegName4,
          ),
          AppsInput(
            inputVO: logic.inputCalegVote4,
          ),
          const SizedBox(height: 18.0,),
          const Divider(),
          AppsInput(
            inputVO: logic.inputCalegName5,
          ),
          AppsInput(
            inputVO: logic.inputCalegVote5,
          ),
        ],
      ),
    );
  }
}