import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SignupTrustSignalsWidget extends StatefulWidget {
  const SignupTrustSignalsWidget({Key? key}) : super(key: key);

  @override
  State<SignupTrustSignalsWidget> createState() =>
      _SignupTrustSignalsWidgetState();
}

class _SignupTrustSignalsWidgetState extends State<SignupTrustSignalsWidget> {
  int _currentStoryIndex = 0;
  late PageController _pageController;

  final List<Map<String, String>> _successStories = [
    {
      'name': 'Arjun Sharma',
      'achievement': 'IIT Delhi - AIR 47',
      'quote': 'Material Hub X helped me crack JEE Advanced!'
    },
    {
      'name': 'Priya Patel',
      'achievement': 'AIIMS Delhi - AIR 12',
      'quote': 'The mock tests were exactly like NEET!'
    },
    {
      'name': 'Rahul Singh',
      'achievement': 'IAS - AIR 23',
      'quote': 'UPSC prep made simple with structured content!'
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-rotate success stories
    Future.delayed(const Duration(seconds: 2), _startRotation);
  }

  void _startRotation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentStoryIndex =
              (_currentStoryIndex + 1) % _successStories.length;
        });
        _pageController.animateToPage(
          _currentStoryIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startRotation();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withAlpha(13),
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withAlpha(26),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Join Statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.groups,
                color: AppTheme.lightTheme.primaryColor,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Join 10L+ successful students',
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Success Stories Carousel
          SizedBox(
            height: 8.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _successStories.length,
              itemBuilder: (context, index) {
                final story = _successStories[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '"${story['quote']}"',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 11.sp,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        '- ${story['name']}, ${story['achievement']}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightTheme.primaryColor,
                          fontSize: 10.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Page Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _successStories.asMap().entries.map((entry) {
              return Container(
                width: 2.w,
                height: 2.w,
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentStoryIndex == entry.key
                      ? AppTheme.lightTheme.primaryColor
                      : AppTheme.lightTheme.colorScheme.onSurfaceVariant
                          .withAlpha(77),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
