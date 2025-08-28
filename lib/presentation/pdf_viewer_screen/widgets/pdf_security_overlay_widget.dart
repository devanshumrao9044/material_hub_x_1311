import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PdfSecurityOverlayWidget extends StatelessWidget {
  final String userEmail;
  final bool isScreenRecordingDetected;
  final VoidCallback onDismiss;

  const PdfSecurityOverlayWidget({
    super.key,
    required this.userEmail,
    this.isScreenRecordingDetected = false,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return isScreenRecordingDetected
        ? _buildScreenRecordingWarning()
        : _buildWatermark();
  }

  Widget _buildWatermark() {
    return Positioned(
      bottom: 20.h,
      right: 4.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userEmail,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: Colors.black.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              DateTime.now().toString().substring(0, 19),
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: Colors.black.withValues(alpha: 0.4),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenRecordingWarning() {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.error
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CustomIconWidget(
                  iconName: 'security',
                  size: 48,
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Screen Recording Detected',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'For content security, this document cannot be viewed while screen recording is active. Please stop recording to continue.',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onDismiss,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        side: BorderSide(
                          color: AppTheme.lightTheme.colorScheme.outline,
                        ),
                      ),
                      child: Text(
                        'Go Back',
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onDismiss,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        backgroundColor:
                            AppTheme.lightTheme.colorScheme.primary,
                      ),
                      child: Text(
                        'Try Again',
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
