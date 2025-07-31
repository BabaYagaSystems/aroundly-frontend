import 'package:flutter/material.dart';

class CreateHappeningField extends StatelessWidget {
  const CreateHappeningField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
