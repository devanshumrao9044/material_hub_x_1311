import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

class AdminActivityFeedWidget extends StatefulWidget {
  const AdminActivityFeedWidget({Key? key}) : super(key: key);

  @override
  State<AdminActivityFeedWidget> createState() =>
      _AdminActivityFeedWidgetState();
}

class _AdminActivityFeedWidgetState extends State<AdminActivityFeedWidget> {
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _activities = [
    {
      'id': 1,
      'type': 'user_registration',
      'title': 'New user registered',
      'description': 'Priya Sharma joined IIT JEE 2025 batch',
      'time': '5 minutes ago',
      'icon': 'person_add',
      'color': Colors.green,
    },
    {
      'id': 2,
      'type': 'content_upload',
      'title': 'Content uploaded',
      'description': 'Physics Chapter 12 - Thermodynamics.pdf uploaded',
      'time': '12 minutes ago',
      'icon': 'upload_file',
      'color': Colors.blue,
    },
    {
      'id': 3,
      'type': 'system_event',
      'title': 'System maintenance',
      'description': 'Database backup completed successfully',
      'time': '1 hour ago',
      'icon': 'settings',
      'color': Colors.orange,
    },
    {
      'id': 4,
      'type': 'user_interaction',
      'title': 'High engagement alert',
      'description': 'Quiz completion rate increased by 15%',
      'time': '2 hours ago',
      'icon': 'trending_up',
      'color': Colors.purple,
    },
    {
      'id': 5,
      'type': 'content_moderation',
      'title': 'Content requires approval',
      'description': '3 new materials pending moderation',
      'time': '3 hours ago',
      'icon': 'gavel',
      'color': Colors.red,
    },
  ];

  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedFilter == 'all') return _activities;
    return _activities
        .where((activity) => activity['type'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'timeline',
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Recent Activity',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: const [
                    DropdownMenuItem(
                        value: 'all', child: Text('All Activities')),
                    DropdownMenuItem(
                        value: 'user_registration', child: Text('User Events')),
                    DropdownMenuItem(
                        value: 'content_upload', child: Text('Content')),
                    DropdownMenuItem(
                        value: 'system_event', child: Text('System')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value ?? 'all';
                    });
                  },
                  underline: Container(),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                itemCount: _filteredActivities.length,
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).dividerColor,
                  height: 3.h,
                ),
                itemBuilder: (context, index) {
                  final activity = _filteredActivities[index];
                  return _buildActivityItem(context, activity);
                },
              ),
            ),
            SizedBox(height: 2.h),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: CustomIconWidget(
                  iconName: 'visibility',
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                label: Text(
                  'View All Activities',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      BuildContext context, Map<String, dynamic> activity) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: (activity['color'] as Color).withValues(alpha: 0.2),
        child: CustomIconWidget(
          iconName: activity['icon'],
          color: activity['color'],
          size: 20,
        ),
      ),
      title: Text(
        activity['title'],
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity['description'],
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 0.5.h),
          Text(
            activity['time'],
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: CustomIconWidget(
          iconName: 'more_vert',
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 16,
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
