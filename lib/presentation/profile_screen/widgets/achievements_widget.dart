import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AchievementsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const AchievementsWidget({
    Key? key,
    required this.achievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Achievements',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full achievements screen
              },
              child: Text(
                'View All',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 15.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            separatorBuilder: (context, index) => SizedBox(width: 3.w),
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              final bool isUnlocked = achievement['unlocked'] as bool;

              return Container(
                width: 25.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(
                    color: isUnlocked
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.dividerColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: isUnlocked
                            ? AppTheme.lightTheme.primaryColor
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: achievement['icon'] as String,
                        color: isUnlocked
                            ? Colors.white
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.5),
                        size: 5.w,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      achievement['title'] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isUnlocked
                            ? AppTheme.lightTheme.colorScheme.onSurface
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (achievement['date'] != null && isUnlocked) ...[
                      SizedBox(height: 0.5.h),
                      Text(
                        achievement['date'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
