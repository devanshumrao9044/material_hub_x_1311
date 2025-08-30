import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/achievements_widget.dart';
import './widgets/leaderboard_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/statistics_grid_widget.dart';
import './widgets/study_analytics_widget.dart';
import './widgets/user_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  int _currentIndex = 4; // Profile tab index

  // Mock user data
  final Map<String, dynamic> userData = {
    "name": "Arjun Sharma",
    "batch": "IIT JEE 2024 - Allen",
    "currentXP": 2450,
    "nextLevelXP": 3000,
    "avatar":
        "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
    "totalStudyHours": 156,
    "testsCompleted": 42,
    "currentStreak": 7,
    "overallRank": 23,
  };

  final List<Map<String, dynamic>> achievements = [
    {
      "id": 1,
      "title": "First Test",
      "icon": "quiz",
      "unlocked": true,
      "date": "Dec 15",
    },
    {
      "id": 2,
      "title": "Study Streak",
      "icon": "local_fire_department",
      "unlocked": true,
      "date": "Dec 20",
    },
    {
      "id": 3,
      "title": "Top Scorer",
      "icon": "emoji_events",
      "unlocked": false,
      "date": null,
    },
    {
      "id": 4,
      "title": "Speed Master",
      "icon": "speed",
      "unlocked": true,
      "date": "Dec 18",
    },
    {
      "id": 5,
      "title": "Consistency",
      "icon": "trending_up",
      "unlocked": false,
      "date": null,
    },
  ];

  final List<Map<String, dynamic>> weeklyData = [
    {"subject": "Physics", "hours": 12},
    {"subject": "Chemistry", "hours": 8},
    {"subject": "Math", "hours": 15},
    {"subject": "Biology", "hours": 6},
  ];

  final List<Map<String, dynamic>> monthlyData = [
    {"subject": "Physics", "hours": 45},
    {"subject": "Chemistry", "hours": 38},
    {"subject": "Math", "hours": 52},
    {"subject": "Biology", "hours": 21},
  ];

  final List<Map<String, dynamic>> leaderboardData = [
    {
      "rank": 1,
      "name": "Priya Patel",
      "xp": 4250,
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
    },
    {
      "rank": 2,
      "name": "Rohit Kumar",
      "xp": 3890,
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
    },
    {
      "rank": 3,
      "name": "Sneha Gupta",
      "xp": 3650,
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Header
              UserHeaderWidget(
                userName: userData['name'] as String,
                batchName: userData['batch'] as String,
                currentXP: userData['currentXP'] as int,
                nextLevelXP: userData['nextLevelXP'] as int,
                avatarUrl: userData['avatar'] as String,
                onAvatarTap: _handleAvatarTap,
              ),
              SizedBox(height: 4.h),

              // Statistics Grid
              StatisticsGridWidget(
                totalStudyHours: userData['totalStudyHours'] as int,
                testsCompleted: userData['testsCompleted'] as int,
                currentStreak: userData['currentStreak'] as int,
                overallRank: userData['overallRank'] as int,
              ),
              SizedBox(height: 4.h),

              // Achievements
              AchievementsWidget(
                achievements: achievements,
              ),
              SizedBox(height: 4.h),

              // contact us 

              bottomSheet: Padding(
  padding: EdgeInsets.all(16.0),
  child: SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.contactUs);
      },
      child: const Text("Contact Us"),
    ),
  ),
),
              // Study Analytics
              StudyAnalyticsWidget(
                weeklyData: weeklyData,
                monthlyData: monthlyData,
              ),
              SizedBox(height: 4.h),

              // Leaderboard
              LeaderboardWidget(
                topUsers: leaderboardData,
                userRank: userData['overallRank'] as int,
                userName: userData['name'] as String,
              ),
              SizedBox(height: 4.h),

              // Settings Section
              SettingsSectionWidget(
                isDarkMode: isDarkMode,
                onThemeToggle: _handleThemeToggle,
                onLogout: _handleLogout,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        selectedItemColor: AppTheme.lightTheme.primaryColor,
        unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'menu_book',
              color: _currentIndex == 0
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'groups',
              color: _currentIndex == 1
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Batches',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'quiz',
              color: _currentIndex == 2
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'store',
              color: _currentIndex == 3
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: _currentIndex == 4
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _handleAvatarTap() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.dividerColor,
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Change Profile Picture',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  icon: 'camera_alt',
                  title: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle camera selection
                  },
                ),
                _buildImageSourceOption(
                  icon: 'photo_library',
                  title: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle gallery selection
                  },
                ),
              ],
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.lightTheme.primaryColor,
                size: 7.w,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleThemeToggle(bool value) {
    setState(() {
      isDarkMode = value;
    });
    // Here you would typically update the app's theme using a state management solution
  }

  void _handleLogout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login-screen',
      (route) => false,
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/study-materials-screen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/home-dashboard');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/quiz-screen');
        break;
      case 3:
        // Navigate to store screen (not implemented)
        break;
      case 4:
        // Already on profile screen
        break;
    }
  }
}
