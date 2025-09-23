import 'package:flutter/material.dart';

class HappeningDescriptionField extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const HappeningDescriptionField({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'Description',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
