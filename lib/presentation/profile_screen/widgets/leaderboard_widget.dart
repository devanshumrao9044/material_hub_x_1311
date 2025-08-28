import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LeaderboardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> topUsers;
  final int userRank;
  final String userName;

  const LeaderboardWidget({
    Key? key,
    required this.topUsers,
    required this.userRank,
    required this.userName,
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
              'Leaderboard',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full leaderboard
              },
              child: Text(
                'View Full Leaderboard',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Container(
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
            children: [
              // Top 3 users
              ...topUsers
                  .take(3)
                  .map((user) => _buildLeaderboardItem(
                        rank: user['rank'] as int,
                        name: user['name'] as String,
                        xp: user['xp'] as int,
                        avatar: user['avatar'] as String,
                        isTopThree: true,
                      ))
                  .toList(),

              if (userRank > 3) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Row(
                    children: [
                      Expanded(
                          child:
                              Divider(color: AppTheme.lightTheme.dividerColor)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          '...',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(
                          child:
                              Divider(color: AppTheme.lightTheme.dividerColor)),
                    ],
                  ),
                ),
                _buildLeaderboardItem(
                  rank: userRank,
                  name: userName,
                  xp: 0, // This would be fetched from user data
                  avatar:
                      'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
                  isCurrentUser: true,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem({
    required int rank,
    required String name,
    required int xp,
    required String avatar,
    bool isTopThree = false,
    bool isCurrentUser = false,
  }) {
    Color? rankColor;
    String? rankIcon;

    if (isTopThree) {
      switch (rank) {
        case 1:
          rankColor = const Color(0xFFFFD700); // Gold
          rankIcon = 'emoji_events';
          break;
        case 2:
          rankColor = const Color(0xFFC0C0C0); // Silver
          rankIcon = 'emoji_events';
          break;
        case 3:
          rankColor = const Color(0xFFCD7F32); // Bronze
          rankIcon = 'emoji_events';
          break;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(2.w),
        border: isCurrentUser
            ? Border.all(color: AppTheme.lightTheme.primaryColor, width: 1)
            : null,
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: rankColor ?? AppTheme.lightTheme.colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: rankIcon != null
                  ? CustomIconWidget(
                      iconName: rankIcon,
                      color: Colors.white,
                      size: 5.w,
                    )
                  : Text(
                      '#$rank',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isTopThree
                            ? Colors.white
                            : AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 3.w),

          // Avatar
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isCurrentUser
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.dividerColor,
                width: 1,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: avatar,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),

          // Name and XP
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isCurrentUser
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '$xp XP',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          if (isCurrentUser)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor,
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Text(
                'You',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
