import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

class AdminContentModerationWidget extends StatefulWidget {
  const AdminContentModerationWidget({Key? key}) : super(key: key);

  @override
  State<AdminContentModerationWidget> createState() =>
      _AdminContentModerationWidgetState();
}

class _AdminContentModerationWidgetState
    extends State<AdminContentModerationWidget> {
  final List<Map<String, dynamic>> _pendingContent = [
    {
      'id': 1,
      'title': 'Advanced Calculus - Integration Techniques',
      'type': 'PDF',
      'uploader': 'Dr. Rajesh Kumar',
      'uploadDate': '2025-01-15',
      'size': '2.5 MB',
      'status': 'pending',
    },
    {
      'id': 2,
      'title': 'Organic Chemistry Video Lecture',
      'type': 'Video',
      'uploader': 'Prof. Meera Singh',
      'uploadDate': '2025-01-14',
      'size': '156 MB',
      'status': 'pending',
    },
    {
      'id': 3,
      'title': 'Physics Mock Test - Mechanics',
      'type': 'Quiz',
      'uploader': 'Admin',
      'uploadDate': '2025-01-13',
      'size': '1.2 MB',
      'status': 'pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Content Moderation',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 3.h),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Pending Review',
                  value: '${_pendingContent.length}',
                  icon: 'pending',
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Approved Today',
                  value: '12',
                  icon: 'check_circle',
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Rejected',
                  value: '3',
                  icon: 'cancel',
                  color: Colors.red,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Pending Content Table
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pending Approval Queue',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _bulkApprove(),
                            icon: CustomIconWidget(
                              iconName: 'done_all',
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 16,
                            ),
                            label: const Text('Bulk Approve'),
                          ),
                          SizedBox(width: 2.w),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: CustomIconWidget(
                              iconName: 'filter_list',
                              color: Theme.of(context).primaryColor,
                              size: 16,
                            ),
                            label: const Text('Filter'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  // Content List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _pendingContent.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 3.h,
                      color: Theme.of(context).dividerColor,
                    ),
                    itemBuilder: (context, index) {
                      final content = _pendingContent[index];
                      return _buildContentItem(context, content, index);
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
              size: 32,
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

  Widget _buildContentItem(
      BuildContext context, Map<String, dynamic> content, int index) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        child: CustomIconWidget(
          iconName: content['type'] == 'PDF'
              ? 'picture_as_pdf'
              : content['type'] == 'Video'
                  ? 'play_circle'
                  : 'quiz',
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        content['title'],
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        'Uploaded by ${content['uploader']} • ${content['uploadDate']} • ${content['size']}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(1.w),
        ),
        child: Text(
          'PENDING',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _previewContent(content),
                      icon: CustomIconWidget(
                        iconName: 'visibility',
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                      label: const Text('Preview'),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _approveContent(index),
                      icon: CustomIconWidget(
                        iconName: 'check',
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 16,
                      ),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _rejectContent(index),
                      icon: CustomIconWidget(
                        iconName: 'close',
                        color: Theme.of(context).colorScheme.onError,
                        size: 16,
                      ),
                      label: const Text('Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _bulkApprove() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bulk Approve'),
        content: Text(
            'Are you sure you want to approve all ${_pendingContent.length} pending items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${_pendingContent.length} items approved successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              setState(() {
                _pendingContent.clear();
              });
            },
            child: const Text('Approve All'),
          ),
        ],
      ),
    );
  }

  void _previewContent(Map<String, dynamic> content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(content['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${content['type']}'),
            Text('Uploader: ${content['uploader']}'),
            Text('Size: ${content['size']}'),
            Text('Upload Date: ${content['uploadDate']}'),
            SizedBox(height: 2.h),
            Container(
              height: 20.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: const Center(
                child: Text('Content Preview\n(Implementation specific)'),
              ),
            ),
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

  void _approveContent(int index) {
    setState(() {
      _pendingContent.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Content approved successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectContent(int index) {
    setState(() {
      _pendingContent.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Content rejected'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
