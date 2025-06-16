import 'package:flutter/material.dart';
import 'package:flutter_migaskita/core/constants/colors.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final IconData icon;

  ActivityCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
