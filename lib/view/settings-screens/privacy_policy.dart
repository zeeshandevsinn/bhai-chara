import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for BHAI CHARA Application',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '1. Introduction:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The BHAI CHARA Application is committed to ensuring the privacy and security of user information. This Privacy Policy outlines the types of personal information collected, how it is used, and the measures taken to protect user privacy.',
            ),
            SizedBox(height: 20),
            Text(
              '2. Information Collected:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2.1 User Profiles:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Users are required to provide detailed profiles including contact information, geographic location, and a brief introduction.',
            ),
            SizedBox(height: 10),
            Text(
              '2.2 Authentication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- The application employs an integrated OTP authentication system and allows users to log in with Google or email/password.',
            ),
            SizedBox(height: 10),
            Text(
              '2.3 Item Posting and Requesting:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Users engaging in item posting or requesting may provide additional information such as item details, descriptions, and images.',
            ),
            SizedBox(height: 20),
            Text(
              '3. Use of Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3.1 User Profiles:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Contact information may be used for communication purposes related to item posting, requesting, and approvals.',
            ),
            SizedBox(height: 10),
            Text(
              '3.2 Authentication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Information obtained during authentication is used for secure login and account recovery processes.',
            ),
            SizedBox(height: 10),
            Text(
              '3.3 Item Posting and Requesting:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Information related to posted items and user requests is used for facilitating the sharing process.',
            ),
            SizedBox(height: 20),
            Text(
              '4. Communication:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '4.1 Direct Communication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- The end-to-end encrypted chat feature ensures user privacy during communication.',
            ),
            Text(
              '- Users receive notifications when new items are added.',
            ),
            SizedBox(height: 20),
            Text(
              '5. Security Measures:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '5.1 End-to-End Encryption:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- All communication within the application is secured with end-to-end encryption, ensuring the privacy of user conversations.',
            ),
            SizedBox(height: 10),
            Text(
              '5.2 User Privacy:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Personal data provided by users is securely stored and processed in compliance with applicable data protection laws.',
            ),
            Text(
              '- Measures are in place to protect against unauthorized access and data breaches.',
            ),
            SizedBox(height: 20),
            Text(
              '6. Non-Transfer of Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'User information, whether personal or transaction-related, is not shared, sold, or transferred to third parties without explicit user consent.',
            ),
            SizedBox(height: 20),
            Text(
              '7. Data Retention:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'User data is retained only for the duration necessary to fulfill the intended purpose. Users have the right to request the deletion of their data.',
            ),
            SizedBox(height: 20),
            Text(
              '8. Policy Updates:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Users will be notified of any changes to the Privacy Policy. Continued use of the application implies acceptance of the updated policy.',
            ),
            SizedBox(height: 20),
            Text(
              '9. Contact Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'For inquiries or concerns regarding privacy, users can contact the BHAI CHARA Application support team at bhai.chara.help@gmail.com.',
            ),
            SizedBox(height: 20),
            Text(
              'By using the BHAI CHARA Application, users acknowledge and agree to the terms outlined in this Privacy Policy.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
