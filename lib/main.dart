import 'package:bhai_chara/controller/provider/authentication_provider/firebase_signup_provider.dart';
import 'package:bhai_chara/controller/provider/product/product_detail.dart';
import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:bhai_chara/firebase_options.dart';
import 'package:bhai_chara/view/chatting/controller/service/chatt_service.dart';
import 'package:bhai_chara/view/home-screens/seachScreen.dart';
import 'package:bhai_chara/view/onboard_screens/splash_screen.dart';
// import 'package:bhai_chara/view/testfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'controller/provider/Image_Picker/compress_provider.dart';
import 'controller/provider/amountprovider/amountprovider.dart';
import 'controller/provider/authentication_provider/auth_provider.dart';
import 'controller/provider/authentication_provider/login_provider.dart';
import 'controller/provider/authentication_provider/variable.dart';
import 'controller/provider/firebase/addImages.dart';
import 'controller/provider/firebase/addproduct.dart';
import 'controller/provider/premiumprovider/premiumprovider.dart';
import 'controller/provider/priceprovider/select_type_provider.dart';
import 'controller/provider/root_provider.dart';
import 'controller/provider/sellscreen_provider/sellscreenprovider.dart';
import 'controller/provider/slider_provider.dart';
import 'controller/provider/switch_provider.dart';
import 'controller/provider/timer_provider.dart';
import 'controller/provider/visibility_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.initializeSharedPreferences();
  Stripe.publishableKey = "pk_test_51St7HRPPkLMB9mdQxWR0VXPBB7TZpCPeVUN05vR8N2vyI2XnLGWfJkbJlKj2kxX2GsixDOi8joghkw0UU6fFlrqx00CwnpMfOF"; // 🟢 SAFE KEY
  for (var app in Firebase.apps) {
    print("Initialized Firebase app: ${app.name}");
  }

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        name: 'primaryApp',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await FirebaseMessaging.instance.setAutoInitEnabled(true);

  runApp(const MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   setupFlutterNotifications();
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }

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
          ChangeNotifierProvider(create: (context) => VisibilityProvider1()),
          ChangeNotifierProvider(create: (context) => VisibilityProvider2()),
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
          ChangeNotifierProvider(create: (context) => SelectionProvider()),
          ChangeNotifierProvider(create: (context) => SelectedType()),
          ChangeNotifierProvider(create: (context) => SellScreenProvider()),
          ChangeNotifierProvider(create: (context) => Amountprovider()),
          ChangeNotifierProvider(create: (context) => VariableProvider()),
          ChangeNotifierProvider(create: (context) => Premiumprovider())
          // ChangeNotifierProvider(create: (context) => ProfileEditProvider()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   fontFamily: "Lora-Regular",
            // ),
            home: const SplashScreen(),
          );
        }));
  }
}
