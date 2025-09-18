import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final bool enabled; // ← NEW
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.enabled = true, // ← NEW (default true)
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled, // ← forward
      obscureText: isObscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if ((value ?? '').trim().isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
