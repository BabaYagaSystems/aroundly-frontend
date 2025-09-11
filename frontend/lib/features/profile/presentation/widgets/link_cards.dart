import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/app_colors.dart';

class LinkCards extends StatelessWidget {
  final String linkLabel;
  const LinkCards({super.key, required this.linkLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 365,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark10,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.person),
            Text(linkLabel),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
