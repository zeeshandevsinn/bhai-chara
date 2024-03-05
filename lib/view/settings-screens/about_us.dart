import 'package:bhai_chara/controller/services/url_launcher.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blue,
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BHAI CHARA Application:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to BHAI CHARA, where technology meets compassion, and sharing transforms communities. At BHAI CHARA, we believe in the power of collaboration to address pressing societal issues. Our application is not just a platform; it\'s a movement dedicated to reducing household and food wastage through the spirit of brotherhood and sharing.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Mission:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'At the core of BHAI CHARA is a mission to create a sustainable ecosystem for sharing and reusing surplus food and household items. We aim to bridge the gap between those with resources to spare and those in need, fostering a sense of community and care for our planet.',
            ),
            const SizedBox(height: 20),
            const Text(
              'The BHAI CHARA Experience:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Effortless Sharing: BHAI CHARA makes sharing easy and accessible. Whether you have surplus food, household items, or a helping hand to offer, our platform provides a seamless experience to connect with others and make a positive impact.\n\nEmpowering Communities: We envision BHAI CHARA as a catalyst for community empowerment. By promoting collaboration among individual users, businesses, and volunteers, we seek to build stronger, more resilient communities that care for each other and the environment.\n\nInnovation with Purpose: Our application is inspired by the Wall of Kindness model, leveraging technology to bring people together for a common cause. We innovate with a purpose, using digital platforms to address real-world challenges and contribute to a more sustainable future.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Why Choose BHAI CHARA:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Purpose-Driven: BHAI CHARA is more than just a sharing app; it\'s a purpose-driven initiative aimed at making a meaningful difference in reducing waste and building community bonds.\n\nUser-Centric: We prioritize user experience, ensuring that our platform is user-friendly, secure, and equipped with features that make sharing and connecting a delightful experience.\n\nSocial Impact: Join us in creating a positive social impact. Every item shared, every connection made, contributes to a more sustainable and compassionate world.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect with BHAI CHARA:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Contact us on ',
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
                        String subject = 'About Inquiry';
                        composeMail(emailAddress, subject);
                      },
                  ),
                  const TextSpan(
                    text:
                        ' and be part of the BHAI CHARA family. Together, let\'s share, care, and make a difference in the world.\n\nThank you for choosing BHAI CHARA—where sharing is not just an action but a way of life.',
                    style: TextStyle(color: Colors.black),
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
