import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/theme.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final bool loading;
  const MyButton({
    super.key,
    required this.btnText,
    this.onPressed,
    this.bgColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        backgroundColor: bgColor ?? AppColors.primary,
        foregroundColor: Colors.black,
        fixedSize: const Size(365, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: loading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              btnText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
    );
  }
}
