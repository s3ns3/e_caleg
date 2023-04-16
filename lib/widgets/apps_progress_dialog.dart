
import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class AppsProgressDialog {
  final BuildContext context;
  final String title;
  final Future<ServiceResponseVO> logic;

  AppsProgressDialog(this.context, this.title, this.logic);

  Future<ServiceResponseVO> show() async {
    ServiceResponseVO  respVO;
    final pd = ProgressDialog(context,
        title: Text(title),
        message: const Text('Harap tunggu ..'),
    );
    try {
      pd.show();
      respVO = await logic;
    } catch (e) {
      debugPrint('[AppsProgressDialog] error: $e');
      respVO = ServiceResponseVO(rcSystemError, kAppsMsgErrSystem);
    } finally {
      pd.dismiss();
    }
    return respVO;
  }
}