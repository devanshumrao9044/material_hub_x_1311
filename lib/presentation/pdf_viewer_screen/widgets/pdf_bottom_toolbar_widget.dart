import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PdfBottomToolbarWidget extends StatelessWidget {
  final VoidCallback onHighlight;
  final VoidCallback onNote;
  final VoidCallback onSearch;
  final VoidCallback onThumbnails;
  final bool isHighlightActive;
  final bool isNoteActive;

  const PdfBottomToolbarWidget({
    super.key,
    required this.onHighlight,
    required this.onNote,
    required this.onSearch,
    required this.onThumbnails,
    this.isHighlightActive = false,
    this.isNoteActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolButton(
            icon: 'highlight',
            label: 'Highlight',
            isActive: isHighlightActive,
            onTap: onHighlight,
          ),
          _buildToolButton(
            icon: 'note_add',
            label: 'Note',
            isActive: isNoteActive,
            onTap: onNote,
          ),
          _buildToolButton(
            icon: 'search',
            label: 'Search',
            isActive: false,
            onTap: onSearch,
          ),
          _buildToolButton(
            icon: 'view_module',
            label: 'Pages',
            isActive: false,
            onTap: onThumbnails,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.3),
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              size: 24,
              color: isActive
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurface,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: isActive
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurface,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
