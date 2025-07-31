import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/theme.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  const MyButton({super.key, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        fixedSize: const Size(365, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        btnText,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
