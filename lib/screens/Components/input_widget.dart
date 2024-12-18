import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class InputWidget extends StatefulWidget {
  ValueChanged<String?>? valueChanged;
  TextEditingController controller = TextEditingController();
  Icon? icon;
  String placeholder;
  int? maxLines;
  TextInputType? textInputType;
  InputWidget(
      {super.key,
      this.valueChanged,
      this.maxLines,
      this.textInputType,
      required this.placeholder,
      required this.controller,
      this.icon});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final borderSide = const BorderSide(width: 0.4, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return ShadInput(
      onChanged: widget.valueChanged,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines,
      cursorColor: Colors.black,
      controller: widget.controller,
      suffix: widget.icon,
      decoration: ShadDecoration(
          color: Colors.white,
          border: ShadBorder(
              top: borderSide,
              left: borderSide,
              right: borderSide,
              bottom: borderSide)),
      placeholder: Text(
        widget.placeholder,
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
