import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final int maxLines;
  final int minLines;
  const TextFormFieldWidget({super.key, 
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        validator: (value) =>
            value!.isEmpty ? "$hintText Can't be Empty" : null,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        maxLines: maxLines,
        minLines: minLines,
      ),
    );
  }
}
