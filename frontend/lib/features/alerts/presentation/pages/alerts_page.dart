import 'package:flutter/material.dart';
import 'package:frontend/features/alerts/presentation/widgets/alert_card.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AlertCard(), AlertCard(), AlertCard()],
          ),
        ),
      ),
    );
  }
}
