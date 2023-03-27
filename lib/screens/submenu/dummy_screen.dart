
import 'package:e_caleg/constants/apps_theme.dart';
import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {
  static const id = 'DummyScreen';

  const DummyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _displayContent(context));
  }

  Widget _displayContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 80.0),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colorPrimary,
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                 'Coming Soon',
                ),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     PhosphorIcons.funnel,
              //     size: 32,
              //   ),
              // )
            ],
          ),
        ),

      ],
    );
  }

}