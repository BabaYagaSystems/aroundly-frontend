import 'package:flutter/material.dart';

class OauthButton extends StatelessWidget {
  final String assetPath;
  final Color backgroundColor;
  final double size;

  const OauthButton({
    super.key,
    required this.assetPath,
    required this.backgroundColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: size * 0.6,
            height: size * 0.6,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
