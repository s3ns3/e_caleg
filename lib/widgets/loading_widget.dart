
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final Future<ServiceResponseVO> Function() futureLogic;
  final Widget child;

  const LoadingWidget({Key? key, required this.child, required this.futureLogic}): super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingWidgetState();

}

class _LoadingWidgetState extends State<LoadingWidget> {

  late Future<ServiceResponseVO> future;

  @override
  void initState() {
    super.initState();
    future = widget.futureLogic();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ServiceResponseVO>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
        ServiceResponseVO respVO = snapshot.data!;
        if (respVO.rc == rcSuccess) {
          return widget.child;
        } else {
          return Center(
            child: Column(
              children: [
                Text(respVO.msg),
                const SizedBox(height: 10),
                AppsButton(
                    label: 'ULANGI',
                    onPressed: () async {
                      setState(() {
                        future = widget.futureLogic();
                      });
                    }
                )
              ],
            )
          );
        }
      }
    );
  }


}