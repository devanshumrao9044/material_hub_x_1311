import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StatisticsGridWidget extends StatelessWidget {
  final int totalStudyHours;
  final int testsCompleted;
  final int currentStreak;
  final int overallRank;

  const StatisticsGridWidget({
    Key? key,
    required this.totalStudyHours,
    required this.testsCompleted,
    required this.currentStreak,
    required this.overallRank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 3.w,
      mainAxisSpacing: 2.h,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          title: 'Study Hours',
          value: totalStudyHours.toString(),
          icon: 'schedule',
          color: AppTheme.getSuccessColor(true),
        ),
        _buildStatCard(
          title: 'Tests Completed',
          value: testsCompleted.toString(),
          icon: 'quiz',
          color: AppTheme.lightTheme.primaryColor,
        ),
        _buildStatCard(
          title: 'Current Streak',
          value: '$currentStreak days',
          icon: 'local_fire_department',
          color: AppTheme.getWarningColor(true),
        ),
        _buildStatCard(
          title: 'Overall Rank',
          value: '#$overallRank',
          icon: 'emoji_events',
          color: AppTheme.getAccentColor(true),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: color,
              size: 6.w,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
