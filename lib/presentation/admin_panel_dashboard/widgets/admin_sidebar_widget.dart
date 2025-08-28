import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AdminSidebarWidget extends StatelessWidget {
  final int selectedIndex;
  final bool isCollapsed;
  final List<String> titles;
  final List<IconData> icons;
  final Function(int) onItemSelected;
  final VoidCallback onToggleCollapsed;

  const AdminSidebarWidget({
    Key? key,
    required this.selectedIndex,
    required this.isCollapsed,
    required this.titles,
    required this.icons,
    required this.onItemSelected,
    required this.onToggleCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 15.w : 60.w,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        border: Border(
          right: BorderSide(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 8.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.lightTheme.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                if (!isCollapsed) ...[
                  Text(
                    'Admin Panel',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                  ),
                  const Spacer(),
                ],
                IconButton(
                  icon: Icon(
                    isCollapsed ? Icons.menu : Icons.menu_open,
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                  onPressed: onToggleCollapsed,
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              itemCount: titles.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onItemSelected(index),
                      borderRadius: BorderRadius.circular(2.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.lightTheme.primaryColor.withAlpha(26)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2.w),
                          border: isSelected
                              ? Border.all(
                                  color: AppTheme.lightTheme.primaryColor
                                      .withAlpha(77),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              icons[index],
                              color: isSelected
                                  ? AppTheme.lightTheme.primaryColor
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                            if (!isCollapsed) ...[
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  titles[index],
                                  style: AppTheme
                                      .lightTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: isSelected
                                        ? AppTheme.lightTheme.primaryColor
                                        : AppTheme
                                            .lightTheme.colorScheme.onSurface,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer
          if (!isCollapsed)
            Container(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Divider(color: AppTheme.lightTheme.dividerColor),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: AppTheme.lightTheme.colorScheme.error,
                        size: 20,
                      ),
                      SizedBox(width: 3.w),
                      GestureDetector(
                        onTap: () {
                          // Handle logout
                          Navigator.pushReplacementNamed(
                              context, '/login-screen');
                        },
                        child: Text(
                          'Logout',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
