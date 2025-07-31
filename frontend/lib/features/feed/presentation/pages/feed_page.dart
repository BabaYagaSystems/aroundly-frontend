import 'package:flutter/material.dart';
import 'package:frontend/features/feed/presentation/widgets/feed_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FeedCard(),
              SizedBox(height: 20),
              FeedCard(),
              SizedBox(height: 20),
              FeedCard(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
