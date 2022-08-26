import 'package:flutter/material.dart';

import '/0_design_system/fc_colors.dart';
import '/0_design_system/fc_dimens.dart';

class DemoTitleWidget extends StatefulWidget {
  final String title;

  const DemoTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<DemoTitleWidget> createState() => _DemoTitleWidgetState();
}

class _DemoTitleWidgetState extends State<DemoTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(FCDimens.margin1, FCDimens.margin2, FCDimens.margin1, FCDimens.margin2),
      child: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: FCColors.darkGray,
        ),
      ),
    );
  }
}
