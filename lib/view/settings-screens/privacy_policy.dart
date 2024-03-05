import 'package:bhai_chara/controller/services/url_launcher.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blue,
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy for BHAI CHARA Application',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Introduction:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The BHAI CHARA Application is committed to ensuring the privacy and security of user information. This Privacy Policy outlines the types of personal information collected, how it is used, and the measures taken to protect user privacy.',
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Information Collected:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '2.1 User Profiles:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Users are required to provide detailed profiles including contact information, geographic location, and a brief introduction.',
            ),
            const SizedBox(height: 10),
            const Text(
              '2.2 Authentication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- The application employs an integrated OTP authentication system and allows users to log in with Google or email/password.',
            ),
            const SizedBox(height: 10),
            const Text(
              '2.3 Item Posting and Requesting:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Users engaging in item posting or requesting may provide additional information such as item details, descriptions, and images.',
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Use of Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '3.1 User Profiles:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Contact information may be used for communication purposes related to item posting, requesting, and approvals.',
            ),
            const SizedBox(height: 10),
            const Text(
              '3.2 Authentication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Information obtained during authentication is used for secure login and account recovery processes.',
            ),
            const SizedBox(height: 10),
            const Text(
              '3.3 Item Posting and Requesting:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Information related to posted items and user requests is used for facilitating the sharing process.',
            ),
            const SizedBox(height: 20),
            const Text(
              '4. Communication:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '4.1 Direct Communication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- The end-to-end encrypted chat feature ensures user privacy during communication.',
            ),
            const Text(
              '- Users receive notifications when new items are added.',
            ),
            const SizedBox(height: 20),
            const Text(
              '5. Security Measures:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '5.1 End-to-End Encryption:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- All communication within the application is secured with end-to-end encryption, ensuring the privacy of user conversations.',
            ),
            const SizedBox(height: 10),
            const Text(
              '5.2 User Privacy:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Personal data provided by users is securely stored and processed in compliance with applicable data protection laws.',
            ),
            const Text(
              '- Measures are in place to protect against unauthorized access and data breaches.',
            ),
            const SizedBox(height: 20),
            const Text(
              '6. Non-Transfer of Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'User information, whether personal or transaction-related, is not shared, sold, or transferred to third parties without explicit user consent.',
            ),
            const SizedBox(height: 20),
            const Text(
              '7. Data Retention:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'User data is retained only for the duration necessary to fulfill the intended purpose. Users have the right to request the deletion of their data.',
            ),
            const SizedBox(height: 20),
            const Text(
              '8. Policy Updates:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Users will be notified of any changes to the Privacy Policy. Continued use of the application implies acceptance of the updated policy.',
            ),
            const SizedBox(height: 20),
            const Text(
              '9. Contact Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text:
                        'For inquiries or concerns regarding privacy, users can contact the BHAI CHARA Application support team at ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'bhai.chara.help@gmail.com',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        String emailAddress = 'bhai.chara.help@gmail.com';
                        String subject='Privacy Inquiry';
                        composeMail(emailAddress,subject);
                      },
                  ),
                  const TextSpan(
                    text: '.',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
           
           
           
            const SizedBox(height: 20),
            const Text(
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

// Future<void> launchEmail(String emailAddress, String subject, String body) async {
//   final Uri params = Uri(
//     scheme: 'mailto',
//     path: emailAddress,
//     query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
//   );

//   var url = params.toString();
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }



}
