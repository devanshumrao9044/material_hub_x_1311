import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Have questions? Reach us at:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('📧 Email: support@materialhub.com'),
            SizedBox(height: 10),
            Text('📞 Phone: +91 9876543210'),
            SizedBox(height: 10),
            Text('🌐 Website: www.materialhub.com'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
