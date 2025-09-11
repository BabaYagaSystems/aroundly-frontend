import 'package:flutter/material.dart';
import 'package:frontend/features/feed/presentation/pages/detailed_feed_page.dart';
import 'package:frontend/shared/themes/theme.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailedFeedPage()),
        );
      },
      child: Container(
        width: 365,
        height: 245,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark10,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Column(
          children: [
            Container(
              width: 365,
              height: 178,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark50,
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Title',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
