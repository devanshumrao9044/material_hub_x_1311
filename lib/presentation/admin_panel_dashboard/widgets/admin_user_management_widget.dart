import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

class AdminUserManagementWidget extends StatefulWidget {
  const AdminUserManagementWidget({Key? key}) : super(key: key);

  @override
  State<AdminUserManagementWidget> createState() =>
      _AdminUserManagementWidgetState();
}

class _AdminUserManagementWidgetState extends State<AdminUserManagementWidget> {
  String _searchQuery = '';
  String _selectedBatchFilter = 'all';
  String _selectedStatusFilter = 'all';

  final List<Map<String, dynamic>> _users = [
    {
      'id': 1,
      'name': 'Rajesh Kumar',
      'email': 'rajesh@example.com',
      'batch': 'IIT JEE 2025 - Allen Kota',
      'status': 'active',
      'registrationDate': '2024-12-15',
      'lastSeen': '2 hours ago',
      'role': 'student',
    },
    {
      'id': 2,
      'name': 'Priya Sharma',
      'email': 'priya@example.com',
      'batch': 'NEET 2025 - Aakash Delhi',
      'status': 'active',
      'registrationDate': '2024-12-10',
      'lastSeen': '1 day ago',
      'role': 'student',
    },
    {
      'id': 3,
      'name': 'Dr. Meera Singh',
      'email': 'meera@materialhubx.com',
      'batch': 'All Batches',
      'status': 'active',
      'registrationDate': '2024-11-01',
      'lastSeen': '30 minutes ago',
      'role': 'instructor',
    },
    {
      'id': 4,
      'name': 'Amit Patel',
      'email': 'amit@example.com',
      'batch': 'UPSC 2025 - Vajiram Chennai',
      'status': 'inactive',
      'registrationDate': '2024-11-20',
      'lastSeen': '1 week ago',
      'role': 'student',
    },
  ];

  List<Map<String, dynamic>> get _filteredUsers {
    return _users.where((user) {
      final matchesSearch =
          user['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              user['email'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesBatch = _selectedBatchFilter == 'all' ||
          user['batch'].contains(_selectedBatchFilter);
      final matchesStatus = _selectedStatusFilter == 'all' ||
          user['status'] == _selectedStatusFilter;

      return matchesSearch && matchesBatch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Management',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 3.h),

          // User Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Total Users',
                  value: _users.length.toString(),
                  icon: 'people',
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Active Users',
                  value: _users
                      .where((u) => u['status'] == 'active')
                      .length
                      .toString(),
                  icon: 'person_check',
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Instructors',
                  value: _users
                      .where((u) => u['role'] == 'instructor')
                      .length
                      .toString(),
                  icon: 'school',
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Search and Filters
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search users by name or email...',
                      prefixIcon: CustomIconWidget(
                        iconName: 'search',
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Filters Row
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedBatchFilter,
                          decoration: const InputDecoration(
                            labelText: 'Batch',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'all', child: Text('All Batches')),
                            DropdownMenuItem(
                                value: 'IIT JEE', child: Text('IIT JEE')),
                            DropdownMenuItem(
                                value: 'NEET', child: Text('NEET')),
                            DropdownMenuItem(
                                value: 'UPSC', child: Text('UPSC')),
                          ],
                          onChanged: (value) => setState(
                              () => _selectedBatchFilter = value ?? 'all'),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatusFilter,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'all', child: Text('All Status')),
                            DropdownMenuItem(
                                value: 'active', child: Text('Active')),
                            DropdownMenuItem(
                                value: 'inactive', child: Text('Inactive')),
                          ],
                          onChanged: (value) => setState(
                              () => _selectedStatusFilter = value ?? 'all'),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      ElevatedButton.icon(
                        onPressed: () => _exportUserData(),
                        icon: CustomIconWidget(
                          iconName: 'file_download',
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        ),
                        label: const Text('Export'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Users Table
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Users (${_filteredUsers.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    height: 50.h,
                    child: ListView.separated(
                      itemCount: _filteredUsers.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 3.h,
                        color: Theme.of(context).dividerColor,
                      ),
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        return _buildUserItem(context, user);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: color,
              size: 28,
            ),
            SizedBox(height: 1.h),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserItem(BuildContext context, Map<String, dynamic> user) {
    final isActive = user['status'] == 'active';
    final isInstructor = user['role'] == 'instructor';

    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: isActive
            ? Colors.green.withValues(alpha: 0.2)
            : Colors.grey.withValues(alpha: 0.2),
        child: Text(
          user['name'][0].toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              user['name'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          if (isInstructor)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Text(
                'INSTRUCTOR',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user['email']),
          Text('${user['batch']} • Last seen: ${user['lastSeen']}'),
        ],
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(1.w),
        ),
        child: Text(
          user['status'].toString().toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isActive ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _viewUserDetails(user),
                  icon: CustomIconWidget(
                    iconName: 'visibility',
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  label: const Text('View Details'),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _changeUserRole(user),
                  icon: CustomIconWidget(
                    iconName: 'admin_panel_settings',
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 16,
                  ),
                  label: const Text('Change Role'),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _toggleUserStatus(user),
                  icon: CustomIconWidget(
                    iconName: isActive ? 'block' : 'check_circle',
                    color: Theme.of(context).colorScheme.onError,
                    size: 16,
                  ),
                  label: Text(isActive ? 'Deactivate' : 'Activate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isActive ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _exportUserData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exporting user data... Download will start shortly.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _viewUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user['email']}'),
            Text('Role: ${user['role']}'),
            Text('Batch: ${user['batch']}'),
            Text('Status: ${user['status']}'),
            Text('Registration: ${user['registrationDate']}'),
            Text('Last Seen: ${user['lastSeen']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _changeUserRole(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Role - ${user['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Student'),
              value: 'student',
              groupValue: user['role'],
              onChanged: (value) {
                Navigator.pop(context);
                _updateUserRole(user, value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('Instructor'),
              value: 'instructor',
              groupValue: user['role'],
              onChanged: (value) {
                Navigator.pop(context);
                _updateUserRole(user, value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('Admin'),
              value: 'admin',
              groupValue: user['role'],
              onChanged: (value) {
                Navigator.pop(context);
                _updateUserRole(user, value!);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _updateUserRole(Map<String, dynamic> user, String newRole) {
    setState(() {
      user['role'] = newRole;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${user['name']} role changed to $newRole'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _toggleUserStatus(Map<String, dynamic> user) {
    final newStatus = user['status'] == 'active' ? 'inactive' : 'active';
    setState(() {
      user['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${user['name']} ${newStatus == 'active' ? 'activated' : 'deactivated'}'),
        backgroundColor: newStatus == 'active' ? Colors.green : Colors.red,
      ),
    );
  }
}
