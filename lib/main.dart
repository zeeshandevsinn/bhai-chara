import 'package:bhai_chara/controller/provider/authentication_provider/firebase_signup_provider.dart';
import 'package:bhai_chara/controller/provider/product/product_detail.dart';
import 'package:bhai_chara/firebase_options.dart';
import 'package:bhai_chara/view/chatting/controller/service/chatt_service.dart';
import 'package:bhai_chara/view/onboard_screens/splash_screen.dart';
// import 'package:bhai_chara/view/testfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'controller/provider/Image_Picker/compress_provider.dart';
import 'controller/provider/authentication_provider/auth_provider.dart';
import 'controller/provider/authentication_provider/login_provider.dart';
import 'controller/provider/firebase/addImages.dart';
import 'controller/provider/firebase/addproduct.dart';
import 'controller/provider/root_provider.dart';
import 'controller/provider/slider_provider.dart';
import 'controller/provider/switch_provider.dart';
import 'controller/provider/timer_provider.dart';
import 'controller/provider/visibility_provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);


  runApp(const MyApp());
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
setupFlutterNotifications();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}


Future<void> setupFlutterNotifications() async {
  await FirebaseMessaging.instance.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TimerProvider()),
          ChangeNotifierProvider(create: (context) => visibilityProvider1()),
          ChangeNotifierProvider(create: (context) => visibilityProvider2()),
          ChangeNotifierProvider(create: (context) => SwitchProvider()),
          ChangeNotifierProvider(create: (context) => SliderProvider()),
          ChangeNotifierProvider(create: (context) => RootProvider()),
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider(create: (context) => FireStoreProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => CompressProvider()),
          ChangeNotifierProvider(create: (context) => ChatService()),
          ChangeNotifierProvider(create: (context) => SignUpProvider()),
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => ProductDetailProvider()),

          // ChangeNotifierProvider(create: (context) => ()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   fontFamily: "Lora-Regular",
            // ),
            home: SplashScreen(),
          );
        }));
  }
}
