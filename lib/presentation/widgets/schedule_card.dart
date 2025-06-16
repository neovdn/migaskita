import 'package:flutter/material.dart';
import 'package:flutter_migaskita/core/constants/colors.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  ScheduleCard({required this.title, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(date, style: TextStyle(color: AppColors.textSecondary)),
          Text(time, style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
