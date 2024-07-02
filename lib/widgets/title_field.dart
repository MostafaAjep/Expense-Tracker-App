import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 50,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }
}
