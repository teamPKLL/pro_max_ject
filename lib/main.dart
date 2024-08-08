import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:pro_max_ject/screen/login_screen.dart';
import 'package:pro_max_ject/screen/map.dart';
import 'package:pro_max_ject/screen/myPage.dart';
import 'package:pro_max_ject/screen/reminder.dart';
import 'package:pro_max_ject/screen/signup.dart';
import 'package:pro_max_ject/screen/widget/Bottom_navi_widget.dart';
import 'package:pro_max_ject/screen/widget/IndexProvider.dart';
import 'package:pro_max_ject/screen/widgetmain.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // Flutter 엔진을 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'c16c44bd57bcaf0c1b866cb6bd1ce937',
    javaScriptAppKey: '8bc1ee40ec3a8a422d71fb1956f0ebf7',
  );

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      ChangeNotifierProvider(
        create: (context) => IndexProvider(),
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUp(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}


