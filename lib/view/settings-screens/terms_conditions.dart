
import 'package:bhai_chara/controller/services/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildTextWithClickableEmail(
            //   'BHAI CHARA Application:',
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to BHAI CHARA! Before you start using our application, please read these terms and conditions carefully. By accessing and using BHAI CHARA, you agree to comply with and be bound by the following terms. If you do not agree with these terms, please do not use the BHAI CHARA application.',
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Acceptance of Terms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'By accessing or using BHAI CHARA, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
            ),
            const SizedBox(height: 20),
            const Text(
              '2. User Eligibility:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You must be at least 18 years old or have the consent of a legal guardian to use BHAI CHARA. By using the application, you affirm that you meet these eligibility criteria.',
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Account Registration:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'To access certain features of BHAI CHARA, you may need to register for an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
            ),
            const SizedBox(height: 20),
            const Text(
              '4. User Conduct:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '4.1 Responsible Sharing: When posting items or engaging in communication within BHAI CHARA, you agree to be respectful, responsible, and considerate of others.\n4.2 Legal Compliance: Users must comply with all applicable laws and regulations while using BHAI CHARA.',
            ),
            const SizedBox(height: 20),
            const Text(
              '5. Privacy:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'BHAI CHARA respects user privacy. Please refer to our Privacy Policy for details on how we collect, use, and protect your personal information.',
            ),
            const SizedBox(height: 20),
            const Text(
              '6. Intellectual Property:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'All content and materials on BHAI CHARA, including but not limited to logos, text, images, and software, are the property of BHAI CHARA and are protected by intellectual property laws.',
            ),
            const SizedBox(height: 20),
            const Text(
              '7. Termination:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'BHAI CHARA reserves the right to terminate or suspend your account at any time for violation of these terms or for any other reason deemed necessary by the BHAI CHARA team.',
            ),
            const SizedBox(height: 20),
            const Text(
              '8. Disclaimer of Warranty:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'BHAI CHARA is provided "as is" without any warranty. We do not guarantee the accuracy, reliability, or availability of the application.',
            ),
            const SizedBox(height: 20),
            const Text(
              '9. Limitation of Liability:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'BHAI CHARA and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the application.',
            ),
            const SizedBox(height: 20),
            const Text(
              '10. Changes to Terms and Conditions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'BHAI CHARA reserves the right to modify or update these terms and conditions at any time. Users will be notified of any changes, and continued use of the application constitutes acceptance of the modified terms.',
            ),
            const SizedBox(height: 20),
  RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Thank you for using BHAI CHARA! If you have any questions or concerns, please contact us at ',
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
                        String subject = 'Terms and Condition Inquiry';
                        composeMail(emailAddress, subject);
                      },
                  ),
                 
                ],
              ),
            ),
          


          ],
        ),
      ),
    );
  }
}
