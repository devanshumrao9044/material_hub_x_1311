import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginLinkWidget extends StatelessWidget {
  const LoginLinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 13.sp,
              ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login-screen');
          },
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
