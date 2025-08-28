import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

class AdminQuickActionsWidget extends StatelessWidget {
  const AdminQuickActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'flash_on',
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Wrap(
              spacing: 3.w,
              runSpacing: 2.h,
              children: [
                _buildQuickActionChip(
                  context,
                  label: 'Batch Upload',
                  icon: 'upload',
                  onTap: () => _showBatchUploadDialog(context),
                ),
                _buildQuickActionChip(
                  context,
                  label: 'User Roles',
                  icon: 'admin_panel_settings',
                  onTap: () {},
                ),
                _buildQuickActionChip(
                  context,
                  label: 'Send Announcement',
                  icon: 'campaign',
                  onTap: () => _showAnnouncementDialog(context),
                ),
                _buildQuickActionChip(
                  context,
                  label: 'Backup Data',
                  icon: 'backup',
                  onTap: () {},
                ),
                _buildQuickActionChip(
                  context,
                  label: 'System Status',
                  icon: 'monitoring',
                  onTap: () {},
                ),
                _buildQuickActionChip(
                  context,
                  label: 'Export Reports',
                  icon: 'file_download',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionChip(
    BuildContext context, {
    required String label,
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBatchUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batch Content Upload'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select content type for batch upload:'),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'pdf', child: Text('PDF Documents')),
                DropdownMenuItem(value: 'video', child: Text('Video Lectures')),
                DropdownMenuItem(value: 'quiz', child: Text('Quiz Materials')),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Content Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_upload),
              label: const Text('Select Files'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  void _showAnnouncementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send System Announcement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Announcement Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Users')),
                DropdownMenuItem(
                    value: 'students', child: Text('Students Only')),
                DropdownMenuItem(value: 'batch', child: Text('Specific Batch')),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Target Audience',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
