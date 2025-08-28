import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AnalyticsSectionWidget extends StatelessWidget {
  const AnalyticsSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Analytics & Reports',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Export analytics
              },
              icon: const Icon(Icons.download, size: 16),
              label: const Text('Export CSV'),
            ),
          ],
        ),
        SizedBox(height: 2.h),

        // Analytics Cards
        Row(
          children: [
            Expanded(
              child: _buildEngagementChart(),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: _buildPerformanceMetrics(),
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Content Popularity Chart
        _buildContentPopularityChart(),
      ],
    );
  }

  Widget _buildEngagementChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Engagement',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Daily active users in the last week',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              height: 20.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < days.length) {
                            return Text(
                              days[value.toInt()],
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                          toY: 65, color: AppTheme.lightTheme.primaryColor)
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                          toY: 78, color: AppTheme.lightTheme.primaryColor)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                          toY: 82, color: AppTheme.lightTheme.primaryColor)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                          toY: 74, color: AppTheme.lightTheme.primaryColor)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(
                          toY: 88, color: AppTheme.lightTheme.primaryColor)
                    ]),
                    BarChartGroupData(x: 5, barRods: [
                      BarChartRodData(
                          toY: 91, color: AppTheme.lightTheme.primaryColor)
                    ]),
                    BarChartGroupData(x: 6, barRods: [
                      BarChartRodData(
                          toY: 69, color: AppTheme.lightTheme.primaryColor)
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    final List<Map<String, dynamic>> metrics = [
      {
        'label': 'Avg. Session Duration',
        'value': '18.5 min',
        'change': '+5.2%',
        'positive': true
      },
      {
        'label': 'Bounce Rate',
        'value': '23.4%',
        'change': '-2.1%',
        'positive': true
      },
      {
        'label': 'Course Completion',
        'value': '76.8%',
        'change': '+12.3%',
        'positive': true
      },
      {
        'label': 'User Satisfaction',
        'value': '4.7/5',
        'change': '+0.2',
        'positive': true
      },
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Key performance indicators',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 3.h),
            ...metrics.map((metric) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            metric['label'],
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            metric['value'],
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: metric['positive']
                            ? AppTheme.getSuccessColor(true).withAlpha(26)
                            : AppTheme.lightTheme.colorScheme.error
                                .withAlpha(26),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        metric['change'],
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: metric['positive']
                              ? AppTheme.getSuccessColor(true)
                              : AppTheme.lightTheme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentPopularityChart() {
    final List<Map<String, dynamic>> contentData = [
      {'title': 'Physics Mock Test 15', 'views': 1247, 'rating': 4.8},
      {'title': 'Organic Chemistry Notes', 'views': 982, 'rating': 4.6},
      {'title': 'Mathematics Video Lecture', 'views': 856, 'rating': 4.9},
      {'title': 'Current Affairs Quiz', 'views': 743, 'rating': 4.4},
      {'title': 'Biology Diagrams', 'views': 651, 'rating': 4.7},
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Content Popularity Rankings',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Most viewed content this month',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 3.h),
            ...contentData.asMap().entries.map((entry) {
              final index = entry.key;
              final content = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
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
                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 14,
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                '${content['views']} views',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Icon(
                                Icons.star,
                                size: 14,
                                color: AppTheme.getWarningColor(true),
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                '${content['rating']}',
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
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
