import 'package:flutter/material.dart';

import '../../0_design_system/fc_colors.dart';

class FCTextFieldWidget extends StatefulWidget {
  final TextEditingController editingController;
  final String label;
  final bool obscureText;

  const FCTextFieldWidget({
    super.key,
    required this.editingController,
    required this.label,
    required this.obscureText,
  });

  @override
  State<FCTextFieldWidget> createState() => _FCTextFieldWidgetState();
}

class _FCTextFieldWidgetState extends State<FCTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      controller: widget.editingController,
      cursorColor: FCColors.green,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(
            color: FCColors.lightGray,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(
            color: FCColors.green,
          ),
        ),
        labelText: widget.label,
        labelStyle: const TextStyle(color: FCColors.darkGray),
      ),
    );
  }
}
