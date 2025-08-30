import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Have questions? Reach us at:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text('📧 Email: support@materialhub.com'),
            const SizedBox(height: 10),
            const Text('📞 Phone: +91 9876543210'),
            const SizedBox(height: 10),
            const Text('🌐 Website: www.materialhub.com'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
