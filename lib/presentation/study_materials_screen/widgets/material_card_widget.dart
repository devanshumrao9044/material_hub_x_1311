import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MaterialCardWidget extends StatelessWidget {
  final Map<String, dynamic> material;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onDownload;
  final VoidCallback? onRemove;
  final bool isSelected;

  const MaterialCardWidget({
    Key? key,
    required this.material,
    this.onTap,
    this.onBookmark,
    this.onDownload,
    this.onRemove,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDownloaded = material['isDownloaded'] ?? false;
    final bool isBookmarked = material['isBookmarked'] ?? false;
    final double progress = (material['progress'] ?? 0.0).toDouble();
    final int pageCount = material['pageCount'] ?? 0;
    final String subject = material['subject'] ?? '';
    final String institute = material['institute'] ?? '';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
            : AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(
                color: AppTheme.lightTheme.colorScheme.primary, width: 2)
            : Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                width: 15.w,
                height: 20.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: material['thumbnail'] != null
                      ? CustomImageWidget(
                          imageUrl: material['thumbnail'],
                          width: 15.w,
                          height: 20.w,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: CustomIconWidget(
                            iconName: 'picture_as_pdf',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 6.w,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 3.w),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and bookmark
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            material['title'] ?? 'Untitled Material',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: onBookmark,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            child: CustomIconWidget(
                              iconName:
                                  isBookmarked ? 'bookmark' : 'bookmark_border',
                              color: isBookmarked
                                  ? AppTheme.lightTheme.colorScheme.primary
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                              size: 5.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Subject and Institute tags
                    Row(
                      children: [
                        if (subject.isNotEmpty) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              subject,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                        ],
                        if (institute.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme
                                  .surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              institute,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Page count and download status
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'description',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '$pageCount pages',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        if (isDownloaded) ...[
                          CustomIconWidget(
                            iconName: 'offline_pin',
                            color: AppTheme.getSuccessColor(true),
                            size: 4.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Downloaded',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.getSuccessColor(true),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ] else ...[
                          GestureDetector(
                            onTap: onDownload,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'download',
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    size: 3.5.w,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    'Download',
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    // Progress bar (if material is partially completed)
                    if (progress > 0 && progress < 1) ...[
                      SizedBox(height: 1.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progress',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '${(progress * 100).toInt()}%',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: AppTheme
                                .lightTheme.colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.lightTheme.colorScheme.primary,
                            ),
                            minHeight: 0.5.h,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
