import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

class AdminMetricsWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const AdminMetricsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 3.w,
      mainAxisSpacing: 2.h,
      childAspectRatio: 1.5,
      children: [
        _buildMetricCard(
          context,
          title: 'Total Users',
          value: _formatNumber(data['totalUsers']),
          icon: 'people',
          trend: '+${data['userGrowthRate']}%',
          trendColor: Colors.green,
        ),
        _buildMetricCard(
          context,
          title: 'Active Batches',
          value: data['activeBatches'].toString(),
          icon: 'school',
          trend: '+12 this week',
          trendColor: Colors.blue,
        ),
        _buildMetricCard(
          context,
          title: 'Content Uploads',
          value: _formatNumber(data['contentUploads']),
          icon: 'upload_file',
          trend: '+247 today',
          trendColor: Colors.purple,
        ),
        _buildMetricCard(
          context,
          title: 'Revenue',
          value: '₹${_formatNumber(data['revenueThisMonth'])}',
          icon: 'trending_up',
          trend: '+${data['engagementRate']}%',
          trendColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required String icon,
    required String trend,
    required Color trendColor,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconWidget(
                  iconName: icon,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: trendColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Text(
                    trend,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: trendColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
