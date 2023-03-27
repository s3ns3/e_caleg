import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:flutter/material.dart';

class LoginLogic {
  static const ID = 'LoginLogic';
  final inputPassword = ContentInputVO(
      paramName: 'paramPassword',
      label: 'Password',
      inputType: ContentInputType.password,
      isLabel: false,
      hasNext: false
  );

  final inputEmail = ContentInputVO(
      label: 'E-mail',
      inputType: ContentInputType.text,
      isLabel: false,
      hasNext: false
  );

  final inputLoginType = ContentInputVO(
      label: 'Login Sebagai',
      inputType: ContentInputType.list,
      isLabel: false,
      hasNext: false
  );

  final inputFistName = ContentInputVO(
      label: 'First Name',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputLastName = ContentInputVO(
      label: 'Last Name',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputBirtDate = ContentInputVO(
      label: 'Birt Date',
      inputType: ContentInputType.date,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputGender = ContentInputVO(
      label: 'Gender',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputCountry = ContentInputVO(
      label: 'Country',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputSkinType = ContentInputVO(
      label: 'Skin Type',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputPregnancyPlaning = ContentInputVO(
      label: 'Pregnancy Planing',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputSmoker = ContentInputVO(
      label: 'Smoker',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputWaterConsumption = ContentInputVO(
      label: 'Water Consumption',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputDietPlan = ContentInputVO(
      label: 'Diet Plan',
      inputType: ContentInputType.list,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputRoutine = ContentInputVO(
      label: 'Routine beauty product currently used',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputMedication = ContentInputVO(
      label: 'Medication',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputAllergies = ContentInputVO(
      label: 'Allergies',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputSurgery = ContentInputVO(
      label: 'Surgery',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
  final inputSkinProblem = ContentInputVO(
      label: 'Skin Problem',
      inputType: ContentInputType.text,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );

  final inputAgree = ContentInputVO(
      label: 'Agree to Term and Conditions',
      inputType: ContentInputType.checkBox,
      color: Colors.transparent,
      isLabel: false,
      hasNext: false
  );
}