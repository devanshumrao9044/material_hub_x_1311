import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recentActivities = [
      {
        "id": 1,
        "type": "test",
        "title": "Physics Mock Test 12",
        "score": "85%",
        "timestamp": "2 hours ago",
        "icon": "quiz",
        "color": AppTheme.getSuccessColor(true),
        "subtitle": "Mechanics & Thermodynamics"
      },
      {
        "id": 2,
        "type": "study",
        "title": "Organic Chemistry",
        "score": "45 min",
        "timestamp": "4 hours ago",
        "icon": "book",
        "color": AppTheme.lightTheme.primaryColor,
        "subtitle": "Chapter 8: Aldehydes & Ketones"
      },
      {
        "id": 3,
        "type": "achievement",
        "title": "Study Streak",
        "score": "7 days",
        "timestamp": "1 day ago",
        "icon": "local_fire_department",
        "color": AppTheme.getWarningColor(true),
        "subtitle": "Keep up the momentum!"
      },
      {
        "id": 4,
        "type": "test",
        "title": "Mathematics Quiz",
        "score": "92%",
        "timestamp": "2 days ago",
        "icon": "calculate",
        "color": AppTheme.getSuccessColor(true),
        "subtitle": "Calculus & Integration"
      },
    ];

    return Container(
      margin: EdgeInsets.only(top: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 20.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: recentActivities.length,
              itemBuilder: (context, index) {
                final activity = recentActivities[index];
                return _buildActivityCard(
                  activity["title"] as String,
                  activity["subtitle"] as String,
                  activity["score"] as String,
                  activity["timestamp"] as String,
                  activity["icon"] as String,
                  activity["color"] as Color,
                  activity["type"] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String subtitle,
    String score,
    String timestamp,
    String iconName,
    Color color,
    String type,
  ) {
    return Container(
      width: 70.w,
      margin: EdgeInsets.only(right: 3.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: iconName,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: type == "test"
                      ? AppTheme.getSuccessColor(true).withValues(alpha: 0.1)
                      : type == "achievement"
                          ? AppTheme.getWarningColor(true)
                              .withValues(alpha: 0.1)
                          : AppTheme.lightTheme.primaryColor
                              .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  score,
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: type == "test"
                        ? AppTheme.getSuccessColor(true)
                        : type == "achievement"
                            ? AppTheme.getWarningColor(true)
                            : AppTheme.lightTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.5.h),
              Text(
                subtitle,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 1.h),
              Text(
                timestamp,
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
