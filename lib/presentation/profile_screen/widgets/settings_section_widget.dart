import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsSectionWidget extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;
  final VoidCallback onLogout;

  const SettingsSectionWidget({
    Key? key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        _buildSettingsGroup(
          title: 'Account',
          items: [
            _SettingsItem(
              icon: 'person',
              title: 'Edit Profile',
              subtitle: 'Update your personal information',
              onTap: () {
                // Navigate to edit profile
              },
            ),
            _SettingsItem(
              icon: 'lock',
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: () {
                // Navigate to change password
              },
            ),
          ],
        ),
        SizedBox(height: 3.h),
        _buildSettingsGroup(
          title: 'Preferences',
          items: [
            _SettingsItem(
              icon: 'dark_mode',
              title: 'Dark Mode',
              subtitle: 'Toggle between light and dark theme',
              trailing: Switch(
                value: isDarkMode,
                onChanged: onThemeToggle,
                activeColor: AppTheme.lightTheme.primaryColor,
              ),
            ),
            _SettingsItem(
              icon: 'notifications',
              title: 'Notifications',
              subtitle: 'Manage your notification preferences',
              onTap: () {
                // Navigate to notification settings
              },
            ),
            _SettingsItem(
              icon: 'language',
              title: 'Language',
              subtitle: 'English',
              onTap: () {
                // Navigate to language settings
              },
            ),
          ],
        ),
        SizedBox(height: 3.h),
        _buildSettingsGroup(
          title: 'Study Settings',
          items: [
            _SettingsItem(
              icon: 'alarm',
              title: 'Study Reminders',
              subtitle: 'Set daily study reminder times',
              onTap: () {
                // Navigate to reminder settings
              },
            ),
            _SettingsItem(
              icon: 'tune',
              title: 'Difficulty Preferences',
              subtitle: 'Customize question difficulty levels',
              onTap: () {
                // Navigate to difficulty settings
              },
            ),
          ],
        ),
        SizedBox(height: 3.h),
        _buildSettingsGroup(
          title: 'Support',
          items: [
            _SettingsItem(
              icon: 'help',
              title: 'Help & FAQ',
              subtitle: 'Get answers to common questions',
              onTap: () {
                // Navigate to help screen
              },
            ),
            _SettingsItem(
              icon: 'feedback',
              title: 'Send Feedback',
              subtitle: 'Share your thoughts and suggestions',
              onTap: () {
                // Navigate to feedback screen
              },
            ),
            _SettingsItem(
              icon: 'contact_support',
              title: 'Contact Us',
              subtitle: 'Get in touch with our support team',
              onTap: () {
                // Navigate to contact screen
              },
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showLogoutDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.w),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'logout',
                  color: Colors.white,
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Logout',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<_SettingsItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
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
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.primaryColor
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: item.icon,
                        color: AppTheme.lightTheme.primaryColor,
                        size: 5.w,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: item.subtitle != null
                        ? Text(
                            item.subtitle!,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        : null,
                    trailing: item.trailing ??
                        CustomIconWidget(
                          iconName: 'chevron_right',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 5.w,
                        ),
                    onTap: item.onTap,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: AppTheme.lightTheme.dividerColor,
                      indent: 18.w,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout from your account?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.lightTheme.colorScheme.error,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Logout',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsItem {
  final String icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });
}
