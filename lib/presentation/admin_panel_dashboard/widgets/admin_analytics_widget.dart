import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

class AdminAnalyticsWidget extends StatefulWidget {
  const AdminAnalyticsWidget({Key? key}) : super(key: key);

  @override
  State<AdminAnalyticsWidget> createState() => _AdminAnalyticsWidgetState();
}

class _AdminAnalyticsWidgetState extends State<AdminAnalyticsWidget> {
  String _selectedTimeRange = '7days';

  final Map<String, dynamic> _analyticsData = {
    'userEngagement': {
      'totalSessions': 12456,
      'averageSessionTime': '24m 30s',
      'bounceRate': '12.3%',
      'dailyActiveUsers': 2847,
    },
    'contentMetrics': {
      'totalDownloads': 8934,
      'videosWatched': 3421,
      'quizCompleted': 1267,
      'avgQuizScore': '78.5%',
    },
    'performanceMetrics': {
      'pageLoadTime': '2.1s',
      'serverUptime': '99.97%',
      'errorRate': '0.02%',
      'apiResponseTime': '180ms',
    }
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Analytics Dashboard',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              DropdownButton<String>(
                value: _selectedTimeRange,
                items: const [
                  DropdownMenuItem(value: '7days', child: Text('Last 7 Days')),
                  DropdownMenuItem(
                      value: '30days', child: Text('Last 30 Days')),
                  DropdownMenuItem(
                      value: '90days', child: Text('Last 90 Days')),
                  DropdownMenuItem(value: '1year', child: Text('Last Year')),
                ],
                onChanged: (value) =>
                    setState(() => _selectedTimeRange = value ?? '7days'),
                underline: Container(),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // User Engagement Section
          _buildSectionCard(
            context,
            title: 'User Engagement',
            icon: 'people',
            color: Colors.blue,
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Total Sessions',
                    _analyticsData['userEngagement']['totalSessions']
                        .toString(),
                    'sessions',
                    Colors.blue,
                  )),
                  SizedBox(width: 2.w),
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Avg Session Time',
                    _analyticsData['userEngagement']['averageSessionTime'],
                    'schedule',
                    Colors.green,
                  )),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Daily Active Users',
                    _analyticsData['userEngagement']['dailyActiveUsers']
                        .toString(),
                    'trending_up',
                    Colors.orange,
                  )),
                  SizedBox(width: 2.w),
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Bounce Rate',
                    _analyticsData['userEngagement']['bounceRate'],
                    'exit_to_app',
                    Colors.red,
                  )),
                ],
              ),
              SizedBox(height: 2.h),
              // Chart placeholder
              Container(
                height: 25.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'show_chart',
                        color: Theme.of(context).primaryColor,
                        size: 48,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'User Engagement Trends Chart',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Interactive chart implementation',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Content Metrics Section
          _buildSectionCard(
            context,
            title: 'Content Performance',
            icon: 'library_books',
            color: Colors.purple,
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Total Downloads',
                    _analyticsData['contentMetrics']['totalDownloads']
                        .toString(),
                    'file_download',
                    Colors.purple,
                  )),
                  SizedBox(width: 2.w),
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Videos Watched',
                    _analyticsData['contentMetrics']['videosWatched']
                        .toString(),
                    'play_circle',
                    Colors.red,
                  )),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Quiz Completed',
                    _analyticsData['contentMetrics']['quizCompleted']
                        .toString(),
                    'quiz',
                    Colors.green,
                  )),
                  SizedBox(width: 2.w),
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Avg Quiz Score',
                    _analyticsData['contentMetrics']['avgQuizScore'],
                    'grade',
                    Colors.amber,
                  )),
                ],
              ),
              SizedBox(height: 2.h),
              // Top Content Table
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Text(
                        'Top Performing Content',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    ...List.generate(
                        5,
                        (index) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.1),
                                child: Text('${index + 1}'),
                              ),
                              title: Text(
                                  'Physics Chapter ${index + 1} - Mock Content'),
                              subtitle:
                                  Text('${(2500 - index * 200)} downloads'),
                              trailing: Text('${(95 - index * 2)}%'),
                            )),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // System Performance Section
          _buildSectionCard(
            context,
            title: 'System Performance',
            icon: 'speed',
            color: Colors.green,
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Page Load Time',
                    _analyticsData['performanceMetrics']['pageLoadTime'],
                    'speed',
                    Colors.green,
                  )),
                  SizedBox(width: 2.w),
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Server Uptime',
                    _analyticsData['performanceMetrics']['serverUptime'],
                    'cloud_done',
                    Colors.blue,
                  )),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'Error Rate',
                    _analyticsData['performanceMetrics']['errorRate'],
                    'error',
                    Colors.red,
                  )),
                  SizedBox(width: 2.w),
                  Expanded(
                      child: _buildMetricTile(
                    context,
                    'API Response Time',
                    _analyticsData['performanceMetrics']['apiResponseTime'],
                    'timer',
                    Colors.orange,
                  )),
                ],
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Export Actions
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export Analytics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 2.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _exportReport('pdf'),
                        icon: CustomIconWidget(
                          iconName: 'picture_as_pdf',
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        ),
                        label: const Text('Export PDF'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _exportReport('excel'),
                        icon: CustomIconWidget(
                          iconName: 'table_chart',
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        ),
                        label: const Text('Export Excel'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _scheduleReport(),
                        icon: CustomIconWidget(
                          iconName: 'schedule',
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                        label: const Text('Schedule Reports'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: icon,
                  color: color,
                  size: 24,
                ),
                SizedBox(width: 2.w),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(
    BuildContext context,
    String title,
    String value,
    String icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: icon,
                color: color,
                size: 20,
              ),
              const Spacer(),
              CustomIconWidget(
                iconName: 'trending_up',
                color: Colors.green,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  void _exportReport(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Exporting analytics report as ${format.toUpperCase()}...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _scheduleReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Schedule Reports'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Frequency',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'daily', child: Text('Daily')),
                DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 2.h),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Recipients',
                border: OutlineInputBorder(),
                hintText: 'admin@materialhubx.com',
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
            child: const Text('Schedule'),
          ),
        ],
      ),
    );
  }
}
