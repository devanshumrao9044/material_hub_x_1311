import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PdfThumbnailsWidget extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageSelected;
  final VoidCallback onClose;

  const PdfThumbnailsWidget({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Page Thumbnails',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onClose,
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
                      iconName: 'close',
                      size: 20,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Thumbnails grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(4.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 2.h,
                childAspectRatio: 0.7,
              ),
              itemCount: totalPages,
              itemBuilder: (context, index) {
                final pageNumber = index + 1;
                final isCurrentPage = pageNumber == currentPage;

                return GestureDetector(
                  onTap: () => onPageSelected(pageNumber),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrentPage
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: 0.3),
                        width: isCurrentPage ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Thumbnail placeholder
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: CustomIconWidget(
                                iconName: 'description',
                                size: 32,
                                color: AppTheme.lightTheme.colorScheme.onSurface
                                    .withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ),

                        // Page number
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Page $pageNumber',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              fontWeight: isCurrentPage
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isCurrentPage
                                  ? AppTheme.lightTheme.colorScheme.primary
                                  : AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
