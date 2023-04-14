import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class FormResultLogic {
  ContentInputVO inputCalegName1 = ContentInputVO(
      label: 'Calon Anggota Dewan 1',
      inputType: ContentInputType.text,
  );
  ContentInputVO inputCalegVote1 = ContentInputVO(
    label: 'Hasil Suara',
    inputType: ContentInputType.numeric,
  );
  ContentInputVO inputCalegName2 = ContentInputVO(
    label: 'Calon Anggota Dewan 2',
    inputType: ContentInputType.text,
  );
  ContentInputVO inputCalegVote2 = ContentInputVO(
    label: 'Hasil Suara',
    inputType: ContentInputType.numeric,
  );
  ContentInputVO inputCalegName3 = ContentInputVO(
    label: 'Calon Anggota Dewan 3',
    inputType: ContentInputType.text,
  );
  ContentInputVO inputCalegVote3 = ContentInputVO(
    label: 'Hasil Suara',
    inputType: ContentInputType.numeric,
  );
  ContentInputVO inputCalegName4 = ContentInputVO(
    label: 'Calon Anggota Dewan 4',
    inputType: ContentInputType.text,
  );
  ContentInputVO inputCalegVote4 = ContentInputVO(
    label: 'Hasil Suara',
    inputType: ContentInputType.numeric,
  );
  ContentInputVO inputCalegName5 = ContentInputVO(
    label: 'Calon Anggota Dewan 5',
    inputType: ContentInputType.text,
  );
  ContentInputVO inputCalegVote5 = ContentInputVO(
    label: 'Hasil Suara',
    inputType: ContentInputType.numeric,
  );

  void parseRecognizedText(RecognizedText recognizedText) {
    String text = recognizedText.text;
    debugPrint("Recognized Text: $text");
    List<String> names = [];
    int pad = 0;
    int index = 0;
    for (TextBlock block in recognizedText.blocks) {
      if(block.text.toUpperCase() == "SUARA CALON") pad = index;
      if(!hasNumber(block.text)) {
        names.add(block.text.toUpperCase());
        index++;
      }
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
    inputCalegName1.inputValue = names[pad+1];
    inputCalegName2.inputValue = names[pad+2];
    inputCalegName3.inputValue = names[pad+3];
    inputCalegName4.inputValue = names[pad+4];
    inputCalegName5.inputValue = names[pad+5];
  }

  bool hasNumber(String input) {
    final RegExp regex = RegExp(r'[0-9]');
    return regex.hasMatch(input);
  }
}