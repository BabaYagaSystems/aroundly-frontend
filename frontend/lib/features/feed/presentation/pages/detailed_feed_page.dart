import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/app_colors.dart';

class DetailedFeedPage extends StatefulWidget {
  const DetailedFeedPage({super.key});

  @override
  State<DetailedFeedPage> createState() => _DetailedFeedPageState();
}

class _DetailedFeedPageState extends State<DetailedFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A R O U N D L Y"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            children: [
              Container(
                width: 365,
                height: 245,
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark50,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text("Description", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.thumb_up),
                      SizedBox(width: 6),
                      Text("12k"),
                    ],
                  ),
                  SizedBox(width: 25),
                  Row(
                    children: [
                      Icon(Icons.thumb_down),
                      SizedBox(width: 6),
                      Text("12"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
