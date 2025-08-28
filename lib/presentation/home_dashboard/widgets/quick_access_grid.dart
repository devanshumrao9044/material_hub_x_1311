import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickAccessGrid extends StatelessWidget {
  final Function(String) onCardTap;

  const QuickAccessGrid({
    Key? key,
    required this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickAccessItems = [
      {
        "id": "my_batches",
        "title": "My Batches",
        "icon": "school",
        "count": "3",
        "color": AppTheme.lightTheme.primaryColor,
      },
      {
        "id": "battleground",
        "title": "Battleground",
        "icon": "sports_esports",
        "count": "12",
        "color": AppTheme.getSuccessColor(true),
      },
      {
        "id": "my_doubts",
        "title": "My Doubts",
        "icon": "help_outline",
        "count": "5",
        "color": AppTheme.getWarningColor(true),
      },
      {
        "id": "my_history",
        "title": "My History",
        "icon": "history",
        "count": "28",
        "color": AppTheme.getAccentColor(true),
      },
      {
        "id": "downloads",
        "title": "Downloads",
        "icon": "download",
        "count": "15",
        "color": const Color(0xFF06B6D4),
      },
      {
        "id": "bookmarks",
        "title": "Bookmarks",
        "icon": "bookmark",
        "count": "42",
        "color": const Color(0xFFEC4899),
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 1.4,
            ),
            itemCount: quickAccessItems.length,
            itemBuilder: (context, index) {
              final item = quickAccessItems[index];
              return _buildQuickAccessCard(
                context,
                item["title"] as String,
                item["icon"] as String,
                item["count"] as String,
                item["color"] as Color,
                item["id"] as String,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context,
    String title,
    String iconName,
    String count,
    Color color,
    String id,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCardTap(id),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.lightTheme.dividerColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomIconWidget(
                      iconName: iconName,
                      color: color,
                      size: 24,
                    ),
                  ),
                  count != "0"
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            count,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Text(
                        'View all',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'arrow_forward_ios',
                        color: color,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
