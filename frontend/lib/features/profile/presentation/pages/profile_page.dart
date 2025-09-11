import 'package:flutter/material.dart';
import 'package:frontend/features/profile/presentation/widgets/link_cards.dart';
import 'package:frontend/shared/themes/app_colors.dart';
import 'package:frontend/shared/widgets/my_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          children: [
            Container(
              width: 124,
              height: 124,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark50,
                borderRadius: BorderRadius.all(Radius.circular(80)),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              "Name Surname",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 30.0),
            LinkCards(linkLabel: "First"),
            SizedBox(height: 20.0),
            LinkCards(linkLabel: "Second"),
            SizedBox(height: 20.0),
            LinkCards(linkLabel: "Third"),
            SizedBox(height: 70.0),
            MyButton(btnText: "Log Out", onPressed: () {}),
            SizedBox(height: 15),
            MyButton(btnText: "Deactivate", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
