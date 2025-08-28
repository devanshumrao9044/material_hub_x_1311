import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'New user registration',
        'subtitle': 'Arjun Sharma joined IIT JEE 2025 batch',
        'time': '2 minutes ago',
        'icon': Icons.person_add,
        'color': AppTheme.getSuccessColor(true),
      },
      {
        'title': 'Content uploaded',
        'subtitle': 'Physics Mock Test 15 added to library',
        'time': '15 minutes ago',
        'icon': Icons.upload,
        'color': AppTheme.lightTheme.primaryColor,
      },
      {
        'title': 'Batch assignment',
        'subtitle': '25 students moved to NEET Advanced batch',
        'time': '1 hour ago',
        'icon': Icons.group,
        'color': AppTheme.getAccentColor(true),
      },
      {
        'title': 'System maintenance',
        'subtitle': 'Database backup completed successfully',
        'time': '3 hours ago',
        'icon': Icons.build,
        'color': AppTheme.getWarningColor(true),
      },
      {
        'title': 'Performance alert',
        'subtitle': 'Server response time increased',
        'time': '5 hours ago',
        'icon': Icons.warning,
        'color': AppTheme.lightTheme.colorScheme.error,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                // View all activities
              },
              child: Text(
                'View All',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => Divider(
              color: AppTheme.lightTheme.dividerColor,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 1.h,
                ),
                leading: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: activity['color'].withAlpha(26),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Icon(
                    activity['icon'],
                    color: activity['color'],
                    size: 20,
                  ),
                ),
                title: Text(
                  activity['title'],
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['subtitle'],
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      activity['time'],
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                trailing: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'view',
                      child: Text('View Details'),
                    ),
                    const PopupMenuItem(
                      value: 'mark_read',
                      child: Text('Mark as Read'),
                    ),
                  ],
                  onSelected: (value) {
                    // Handle menu actions
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
