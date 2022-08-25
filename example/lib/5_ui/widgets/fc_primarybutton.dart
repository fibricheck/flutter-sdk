import 'package:flutter/material.dart';

import '../../0_design_system/fc_colors.dart';

class FCPrimaryButtonWidget extends StatefulWidget {
  final Function onPressed;
  final String label;

  const FCPrimaryButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  State<FCPrimaryButtonWidget> createState() => _FCPrimaryButtonWidgetState();
}

class _FCPrimaryButtonWidgetState extends State<FCPrimaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: FCColors.green,
        border: Border(
          top: BorderSide(width: .5, color: FCColors.lightGray),
          left: BorderSide(width: .5, color: FCColors.lightGray),
          right: BorderSide(width: .5, color: FCColors.lightGray),
          bottom: BorderSide(width: .5, color: FCColors.lightGray),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextButton(
        child: Text(
          widget.label,
          style: const TextStyle(color: FCColors.brokenWhite),
        ),
        onPressed: () => {widget.onPressed()},
      ),
    );
  }
}
