import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ContentModerationWidget extends StatelessWidget {
  const ContentModerationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pendingContent = [
      {
        'title': 'Physics Mock Test 16',
        'type': 'Quiz',
        'batch': 'IIT JEE 2025',
        'uploadedBy': 'Prof. Sharma',
        'uploadDate': '2 hours ago',
        'status': 'pending',
      },
      {
        'title': 'Organic Chemistry Notes',
        'type': 'Document',
        'batch': 'NEET 2025',
        'uploadedBy': 'Dr. Patel',
        'uploadDate': '4 hours ago',
        'status': 'pending',
      },
      {
        'title': 'Mathematics Video Lecture',
        'type': 'Video',
        'batch': 'IIT JEE Advanced',
        'uploadedBy': 'Prof. Kumar',
        'uploadDate': '1 day ago',
        'status': 'pending',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content Moderation Queue',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Card(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary.withAlpha(13),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Pending Approvals (${pendingContent.length})',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Bulk approve
                      },
                      icon: const Icon(Icons.check_circle, size: 16),
                      label: const Text('Approve All'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.getSuccessColor(true),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pendingContent.length,
                separatorBuilder: (context, index) => Divider(
                  color: AppTheme.lightTheme.dividerColor,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final content = pendingContent[index];
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      children: [
                        // Content Type Icon
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: _getContentTypeColor(content['type'])
                                .withAlpha(26),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Icon(
                            _getContentTypeIcon(content['type']),
                            color: _getContentTypeColor(content['type']),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 3.w),

                        // Content Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                content['title'],
                                style: AppTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                '${content['type']} • ${content['batch']}',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                'Uploaded by ${content['uploadedBy']} • ${content['uploadDate']}',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Action Buttons
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                // Preview content
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppTheme.lightTheme.primaryColor,
                                ),
                              ),
                              child: const Text('Preview'),
                            ),
                            SizedBox(width: 2.w),
                            ElevatedButton(
                              onPressed: () {
                                // Approve content
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.getSuccessColor(true),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Approve'),
                            ),
                            SizedBox(width: 2.w),
                            ElevatedButton(
                              onPressed: () {
                                // Reject content
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppTheme.lightTheme.colorScheme.error,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Reject'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getContentTypeIcon(String type) {
    switch (type) {
      case 'Quiz':
        return Icons.quiz;
      case 'Document':
        return Icons.description;
      case 'Video':
        return Icons.play_circle;
      default:
        return Icons.file_copy;
    }
  }

  Color _getContentTypeColor(String type) {
    switch (type) {
      case 'Quiz':
        return AppTheme.lightTheme.primaryColor;
      case 'Document':
        return AppTheme.getAccentColor(true);
      case 'Video':
        return AppTheme.getWarningColor(true);
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }
}
