import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import './widgets/app_logo_widget.dart';
import './widgets/login_form_widget.dart';
import './widgets/signup_link_widget.dart';
import './widgets/trust_signals_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'student@materialhubx.com': 'student123',
    'admin@materialhubx.com': 'admin123',
    'demo@materialhubx.com': 'demo123',
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Check mock credentials
    if (_mockCredentials.containsKey(email.toLowerCase()) &&
        _mockCredentials[email.toLowerCase()] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      if (mounted) {
        // Check if admin user
        if (email.toLowerCase() == 'admin@materialhubx.com') {
          Navigator.pushReplacementNamed(context, '/admin-panel-dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/home-dashboard');
        }
      }
    } else {
      // Failed login
      HapticFeedback.heavyImpact();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid email or password. Please try again.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(4.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Dismiss keyboard when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.h),

                    // App Logo
                    const AppLogoWidget(),

                    SizedBox(height: 6.h),

                    // Welcome Text
                    Column(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 22.sp,
                              ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Sign in to continue your learning journey',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 13.sp,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Login Form
                    LoginFormWidget(
                      onLogin: _handleLogin,
                      isLoading: _isLoading,
                    ),

                    // Trust Signals
                    const TrustSignalsWidget(),

                    const Spacer(),

                    // Sign Up Link
                    const SignupLinkWidget(),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
