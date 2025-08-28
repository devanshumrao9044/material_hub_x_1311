import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class StudyAnalyticsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> weeklyData;
  final List<Map<String, dynamic>> monthlyData;

  const StudyAnalyticsWidget({
    Key? key,
    required this.weeklyData,
    required this.monthlyData,
  }) : super(key: key);

  @override
  State<StudyAnalyticsWidget> createState() => _StudyAnalyticsWidgetState();
}

class _StudyAnalyticsWidgetState extends State<StudyAnalyticsWidget> {
  bool isWeeklyView = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Study Analytics',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildToggleButton('Week', isWeeklyView),
                  _buildToggleButton('Month', !isWeeklyView),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          height: 30.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(3.w),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _getMaxValue(),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: AppTheme.lightTheme.primaryColor,
                        tooltipRoundedRadius: 2.w,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final data = isWeeklyView
                              ? widget.weeklyData
                              : widget.monthlyData;
                          return BarTooltipItem(
                            '${data[group.x.toInt()]['subject']}\n${rod.toY.toInt()}h',
                            AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final data = isWeeklyView
                                ? widget.weeklyData
                                : widget.monthlyData;
                            if (value.toInt() < data.length) {
                              return Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Text(
                                  data[value.toInt()]['subject'] as String,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontSize: 10.sp,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 10.w,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}h',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                fontSize: 10.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: _buildBarGroups(),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 2,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: AppTheme.lightTheme.dividerColor,
                          strokeWidth: 1,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isWeeklyView = text == 'Week';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Text(
          text,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? Colors.white
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    final data = isWeeklyView ? widget.weeklyData : widget.monthlyData;
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (item['hours'] as num).toDouble(),
            color: AppTheme.lightTheme.primaryColor,
            width: 6.w,
            borderRadius: BorderRadius.circular(1.w),
          ),
        ],
      );
    }).toList();
  }

  double _getMaxValue() {
    final data = isWeeklyView ? widget.weeklyData : widget.monthlyData;
    final maxHours = data
        .map((item) => item['hours'] as num)
        .reduce((a, b) => a > b ? a : b);
    return (maxHours.toDouble() * 1.2).ceilToDouble();
  }
}