import 'package:flutter/material.dart';

class CreateHappeningField extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const CreateHappeningField({super.key, this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Title',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      textInputAction: TextInputAction.next,
    );
  }
}
