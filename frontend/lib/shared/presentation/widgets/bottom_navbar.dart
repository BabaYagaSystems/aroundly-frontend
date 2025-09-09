import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/app_colors.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          kBottomNavigationBarHeight +
          40, // Increased height for labels and spacing
      decoration: BoxDecoration(
        color: AppColors.surfaceDark10,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: Colors.transparent,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10.0, // Increased for more space around FAB
          child: SafeArea(
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Even spacing including edges
              children: [
                // Map
                _buildNavItem(icon: Icons.map, label: 'Map', index: 0),
                // Feed
                _buildNavItem(icon: Icons.feed, label: 'Feed', index: 1),
                // Alerts
                SizedBox(width: 60),
                _buildNavItem(
                  icon: Icons.notifications,
                  label: 'Alerts',
                  index: 2,
                ),
                // Profile
                _buildNavItem(icon: Icons.person, label: 'Profile', index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedIndex == index
                  ? AppColors.primary20
                  : AppColors.surfaceDark40,
              size: 24,
            ),
            const SizedBox(height: 4), // Spacing between icon and label
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: selectedIndex == index
                    ? AppColors.primary20
                    : AppColors.surfaceDark40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
