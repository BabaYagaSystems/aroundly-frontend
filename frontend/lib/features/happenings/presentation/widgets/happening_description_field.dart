import 'package:flutter/material.dart';

class HappeningDescriptionField extends StatelessWidget {
  const HappeningDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Description', floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
