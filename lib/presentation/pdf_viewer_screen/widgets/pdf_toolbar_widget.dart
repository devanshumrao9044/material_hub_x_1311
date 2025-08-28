import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PdfToolbarWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final double zoomLevel;
  final bool isBookmarked;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onBookmarkToggle;
  final VoidCallback onSearch;
  final VoidCallback onTableOfContents;

  const PdfToolbarWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.zoomLevel,
    required this.isBookmarked,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onBookmarkToggle,
    required this.onSearch,
    required this.onTableOfContents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Page navigation
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primaryContainer
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$currentPage / $totalPages',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ),

          SizedBox(width: 4.w),

          // Zoom controls
          Row(
            children: [
              GestureDetector(
                onTap: onZoomOut,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: 'zoom_out',
                    size: 20,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                '${(zoomLevel * 100).toInt()}%',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: onZoomIn,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: 'zoom_in',
                    size: 20,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Action buttons
          Row(
            children: [
              GestureDetector(
                onTap: onSearch,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: 'search',
                    size: 20,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              GestureDetector(
                onTap: onBookmarkToggle,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: isBookmarked
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isBookmarked
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: isBookmarked ? 'bookmark' : 'bookmark_border',
                    size: 20,
                    color: isBookmarked
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              GestureDetector(
                onTap: onTableOfContents,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: 'list',
                    size: 20,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
