import 'package:comixnook_prj/screens/auth/forget_password_screen.dart';
import 'package:comixnook_prj/screens/auth/login_screen.dart';
import 'package:comixnook_prj/screens/auth/register_screen.dart';
import 'package:comixnook_prj/screens/dashboard/dashboard.dart';
import 'package:comixnook_prj/screens/splash_screen.dart';
import 'package:comixnook_prj/services/notification_service.dart';
import 'package:comixnook_prj/viewmodels/auth_viewmodel.dart';
import 'package:comixnook_prj/viewmodels/global_ui_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: OverlayKit(
        child: Consumer<GlobalUIViewModel>(builder: (context, loader, child) {
          if (loader.isLoading) {
            OverlayLoadingProgress.start();
          } else {
            OverlayLoadingProgress.stop();
          }
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.purple,
              textTheme: GoogleFonts.aBeeZeeTextTheme(),
            ),
            initialRoute: "/splash",
            routes: {
              "/login": (BuildContext context) => LoginScreen(),
              "/splash": (BuildContext context) => SplashScreen(),
              "/register": (BuildContext context) => RegisterScreen(),
              "/forget-password": (BuildContext context) => ForgetPasswordScreen(),
              "/dashboard": (BuildContext context) => DashboardScreen(),
            },
          );
        }),
      ),
    );
  }
}