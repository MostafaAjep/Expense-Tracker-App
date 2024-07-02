import 'package:flutter/material.dart';

class ButtonsRow extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  const ButtonsRow({
    super.key,
    required this.onCancelPressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: onCancelPressed,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSavePressed,
          child: const Text('Save expense'),
        ),
      ],
    );
  }
}
