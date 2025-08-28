import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class DashboardMetricsWidget extends StatelessWidget {
  const DashboardMetricsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),

        // Metrics Cards Grid
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 3.w,
          crossAxisSpacing: 3.w,
          childAspectRatio: 1.5,
          children: [
            _buildMetricCard(
              title: 'Total Users',
              value: '24,847',
              change: '+12.5%',
              changeColor: AppTheme.getSuccessColor(true),
              icon: Icons.people,
              iconColor: AppTheme.lightTheme.primaryColor,
            ),
            _buildMetricCard(
              title: 'Active Batches',
              value: '156',
              change: '+8.3%',
              changeColor: AppTheme.getSuccessColor(true),
              icon: Icons.school,
              iconColor: AppTheme.getAccentColor(true),
            ),
            _buildMetricCard(
              title: 'Content Library',
              value: '12,340',
              change: '+15.2%',
              changeColor: AppTheme.getSuccessColor(true),
              icon: Icons.library_books,
              iconColor: AppTheme.getWarningColor(true),
            ),
            _buildMetricCard(
              title: 'Revenue',
              value: '₹4.2L',
              change: '-2.1%',
              changeColor: AppTheme.lightTheme.colorScheme.error,
              icon: Icons.currency_rupee,
              iconColor: AppTheme.getSuccessColor(true),
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Charts Section
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildUserGrowthChart(),
            ),
            SizedBox(width: 3.w),
            Expanded(
              flex: 1,
              child: _buildBatchDistribution(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String change,
    required Color changeColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: changeColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    change,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: changeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserGrowthChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Growth (Last 6 Months)',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              height: 25.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                            'Jun'
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            return Text(
                              months[value.toInt()],
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
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 30,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 15),
                        const FlSpot(1, 18),
                        const FlSpot(2, 22),
                        const FlSpot(3, 20),
                        const FlSpot(4, 25),
                        const FlSpot(5, 28),
                      ],
                      isCurved: true,
                      color: AppTheme.lightTheme.primaryColor,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppTheme.lightTheme.primaryColor.withAlpha(26),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchDistribution() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Batch Distribution',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              height: 25.h,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      title: 'IIT JEE',
                      color: AppTheme.lightTheme.primaryColor,
                      radius: 8.w,
                      titleStyle:
                          AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PieChartSectionData(
                      value: 35,
                      title: 'NEET',
                      color: AppTheme.getAccentColor(true),
                      radius: 8.w,
                      titleStyle:
                          AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: 'UPSC',
                      color: AppTheme.getWarningColor(true),
                      radius: 8.w,
                      titleStyle:
                          AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  centerSpaceRadius: 6.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
