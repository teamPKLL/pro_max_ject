import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:pro_max_ject/api/disaster_provider.dart';
import 'package:pro_max_ject/api/shelter_provider.dart';
import 'package:pro_max_ject/screen/login_screen.dart';
import 'package:pro_max_ject/screen/map.dart';
import 'package:pro_max_ject/screen/signup.dart';
import 'package:pro_max_ject/screen/widget/Bottom_navi_widget.dart';
import 'package:pro_max_ject/screen/widget/IndexProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


Future<void> main() async {
  // Flutter 엔진을 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오맵 테스트
  await dotenv.load(fileName: ".env");
  AuthRepository.initialize(
    appKey: dotenv.env['APP_KEY'] ?? '');

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'c16c44bd57bcaf0c1b866cb6bd1ce937',
    javaScriptAppKey: '8bc1ee40ec3a8a422d71fb1956f0ebf7',
  );

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 로그인 상태 확인
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // runApp(MapPage());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexProvider()),
        ChangeNotifierProvider(create: (context) => DisasterProvider()), // DisasterProvider 추가
        // 다른 Provider가 있다면 여기에 추가
        ChangeNotifierProvider(create: (context) => ShelterProvider()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );

}
  // runApp(MyApp());


class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ?  '/main' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUp(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Maps Sample App'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
//