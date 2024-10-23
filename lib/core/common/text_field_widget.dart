import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.controllerName,
      required this.textInputType});
  final TextEditingController controller;
  final String controllerName;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        clipBehavior: Clip.antiAlias,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: controllerName,
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
