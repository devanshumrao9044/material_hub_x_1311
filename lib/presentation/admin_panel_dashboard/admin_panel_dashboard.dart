import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/admin_sidebar_widget.dart';
import './widgets/dashboard_metrics_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/recent_activity_widget.dart';
import './widgets/content_moderation_widget.dart';
import './widgets/user_management_widget.dart';
import './widgets/analytics_section_widget.dart';

class AdminPanelDashboard extends StatefulWidget {
  const AdminPanelDashboard({Key? key}) : super(key: key);

  @override
  State<AdminPanelDashboard> createState() => _AdminPanelDashboardState();
}

class _AdminPanelDashboardState extends State<AdminPanelDashboard>
    with TickerProviderStateMixin {
  int _selectedSidebarIndex = 0;
  bool _isSidebarCollapsed = false;

  final List<String> _sidebarTitles = [
    'Dashboard Overview',
    'Content Management',
    'User Management',
    'Analytics & Reports',
    'System Settings',
    'Batch Management',
  ];

  final List<IconData> _sidebarIcons = [
    Icons.dashboard,
    Icons.content_copy,
    Icons.people,
    Icons.analytics,
    Icons.settings,
    Icons.school,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Row(
        children: [
          // Sidebar Navigation
          AdminSidebarWidget(
            selectedIndex: _selectedSidebarIndex,
            isCollapsed: _isSidebarCollapsed,
            titles: _sidebarTitles,
            icons: _sidebarIcons,
            onItemSelected: (index) {
              setState(() {
                _selectedSidebarIndex = index;
              });
            },
            onToggleCollapsed: () {
              setState(() {
                _isSidebarCollapsed = !_isSidebarCollapsed;
              });
            },
          ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top App Bar
                Container(
                  height: 8.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.scaffoldBackgroundColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppTheme.lightTheme.dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _sidebarTitles[_selectedSidebarIndex],
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),

                      // Notifications
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withAlpha(26),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications_outlined,
                              color: AppTheme.lightTheme.primaryColor,
                              size: 24,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 2.w,
                                height: 2.w,
                                decoration: BoxDecoration(
                                  color: AppTheme.lightTheme.colorScheme.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 3.w),

                      // Admin Profile
                      GestureDetector(
                        onTap: () {
                          // Show profile menu
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 4.w,
                              backgroundColor: AppTheme.lightTheme.primaryColor,
                              child: Text(
                                'AD',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Admin User',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Administrator',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedSidebarIndex) {
      case 0:
        return _buildDashboardOverview();
      case 1:
        return _buildContentManagement();
      case 2:
        return _buildUserManagement();
      case 3:
        return _buildAnalyticsReports();
      case 4:
        return _buildSystemSettings();
      case 5:
        return _buildBatchManagement();
      default:
        return _buildDashboardOverview();
    }
  }

  Widget _buildDashboardOverview() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics
          const DashboardMetricsWidget(),

          SizedBox(height: 3.h),

          // Quick Actions
          const QuickActionsWidget(),

          SizedBox(height: 3.h),

          // Recent Activity
          const RecentActivityWidget(),
        ],
      ),
    );
  }

  Widget _buildContentManagement() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentModerationWidget(),
        ],
      ),
    );
  }

  Widget _buildUserManagement() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserManagementWidget(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsReports() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnalyticsSectionWidget(),
        ],
      ),
    );
  }

  Widget _buildSystemSettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Settings',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.security,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    title: const Text('Security Settings'),
                    subtitle: const Text(
                        'Configure authentication and access controls'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to security settings
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.backup,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    title: const Text('Backup & Recovery'),
                    subtitle:
                        const Text('Manage data backups and recovery options'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to backup settings
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    title: const Text('Email Templates'),
                    subtitle:
                        const Text('Customize notification email templates'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to email templates
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchManagement() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batch Management',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.add_circle,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    title: const Text('Create New Batch'),
                    subtitle: const Text('Set up new student batches'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to create batch
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.groups,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    title: const Text('Manage Existing Batches'),
                    subtitle: const Text('View and edit current batches'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to manage batches
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    title: const Text('Batch Assignments'),
                    subtitle: const Text('Assign students to batches'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to batch assignments
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
