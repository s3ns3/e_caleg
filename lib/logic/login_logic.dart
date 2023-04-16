import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/apps_menu_service.dart';
import 'package:e_caleg/service/apps_service.dart';
import 'package:e_caleg/service/login_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
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

  final inputPhoneNo = ContentInputVO(
      label: 'Nomor Hanphone/Username',
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


  final inputNewPassword = ContentInputVO(
    label: 'Password baru',
    autoFocus: true,
    maxLength: 7,
    inputType: ContentInputType.password,
  );
  final inputConfirmPassword = ContentInputVO(
      maxLength: 7,
      label: 'Konfirmasi password baru',
      inputType: ContentInputType.password);

  Future<ServiceResponseVO> initLogic() async {
    // prepare for list of master data
    inputLoginType.selections = AppsService.get()
        .findGeneralSelectionFor(kSelectionItemLoginType);
    return ServiceResponseVO(rcSuccess, '');
  }

  Future<ServiceResponseVO> requestLoginPass() async {
    if (inputPassword.inputValue == '') {
      return ServiceResponseVO(rcValidationError, 'Harap mengisi password');
    }
    if (inputPhoneNo.inputValue == '') {
      return ServiceResponseVO(rcValidationError, 'Harap mengisi ${inputPhoneNo.label!.toLowerCase()}');
    }

    ServiceResponseVO respVO = await LoginService.get().sendLoginPass(inputPhoneNo.inputValue,inputPassword.inputValue);

    return respVO;
  }

}