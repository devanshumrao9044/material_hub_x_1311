import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class UserManagementWidget extends StatefulWidget {
  const UserManagementWidget({Key? key}) : super(key: key);

  @override
  State<UserManagementWidget> createState() => _UserManagementWidgetState();
}

class _UserManagementWidgetState extends State<UserManagementWidget> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Students',
    'Teachers',
    'Admins',
    'Inactive'
  ];

  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Arjun Sharma',
      'email': 'arjun.sharma@email.com',
      'role': 'Student',
      'batch': 'IIT JEE 2025',
      'status': 'Active',
      'joinDate': '15 Jan 2024',
      'avatar': 'AS',
    },
    {
      'name': 'Dr. Priya Patel',
      'email': 'priya.patel@email.com',
      'role': 'Teacher',
      'batch': 'NEET Faculty',
      'status': 'Active',
      'joinDate': '03 Sep 2023',
      'avatar': 'PP',
    },
    {
      'name': 'Rahul Singh',
      'email': 'rahul.singh@email.com',
      'role': 'Student',
      'batch': 'UPSC 2025',
      'status': 'Active',
      'joinDate': '22 Feb 2024',
      'avatar': 'RS',
    },
    {
      'name': 'Prof. Kumar',
      'email': 'kumar@email.com',
      'role': 'Teacher',
      'batch': 'JEE Faculty',
      'status': 'Inactive',
      'joinDate': '10 Aug 2023',
      'avatar': 'PK',
    },
  ];

  List<Map<String, dynamic>> get _filteredUsers {
    return _users.where((user) {
      final matchesSearch =
          user['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              user['email'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' ||
          user['role'] == _selectedFilter ||
          (_selectedFilter == 'Inactive' && user['status'] == 'Inactive');
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Management',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),

        // Search and Filter Bar
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            SizedBox(width: 3.w),
            DropdownButton<String>(
              value: _selectedFilter,
              items: _filters.map((filter) {
                return DropdownMenuItem(
                  value: filter,
                  child: Text(filter),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
              borderRadius: BorderRadius.circular(2.w),
            ),
            SizedBox(width: 3.w),
            ElevatedButton.icon(
              onPressed: () {
                // Add new user
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add User'),
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Users Table
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Batch')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Join Date')),
                DataColumn(label: Text('Actions')),
              ],
              rows: _filteredUsers.map((user) {
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 4.w,
                            backgroundColor: AppTheme.lightTheme.primaryColor,
                            child: Text(
                              user['avatar'],
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user['name'],
                                style: AppTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                user['email'],
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getRoleColor(user['role']).withAlpha(26),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          user['role'],
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: _getRoleColor(user['role']),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(user['batch'])),
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: user['status'] == 'Active'
                              ? AppTheme.getSuccessColor(true).withAlpha(26)
                              : AppTheme.lightTheme.colorScheme.error
                                  .withAlpha(26),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          user['status'],
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: user['status'] == 'Active'
                                ? AppTheme.getSuccessColor(true)
                                : AppTheme.lightTheme.colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(user['joinDate'])),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 16),
                            onPressed: () {
                              // Edit user
                            },
                            tooltip: 'Edit User',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 16),
                            onPressed: () {
                              // Delete user
                            },
                            tooltip: 'Delete User',
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert, size: 16),
                            onPressed: () {
                              // More actions
                            },
                            tooltip: 'More Actions',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),

        SizedBox(height: 2.h),

        // Pagination
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Showing ${_filteredUsers.length} of ${_users.length} users',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Previous page
                  },
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '1',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Next page
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Student':
        return AppTheme.lightTheme.primaryColor;
      case 'Teacher':
        return AppTheme.getAccentColor(true);
      case 'Admin':
        return AppTheme.getWarningColor(true);
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }
}
