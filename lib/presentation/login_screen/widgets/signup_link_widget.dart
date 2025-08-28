import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SignupLinkWidget extends StatelessWidget {
  const SignupLinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New user? ',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              fontSize: 13.sp,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to sign up screen
              Navigator.pushNamed(context, '/sign-up-screen');
            },
            child: Text(
              'Sign Up',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.lightTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
