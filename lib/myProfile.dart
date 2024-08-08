import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  runApp(const MyPage());
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp (options : DefaultFirebaseOptions.currentPlatform);
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( title: Center(child: Text('프로필')),),
        body: MyProfileBodyWidget(),
      )
    );
  }
}

class MyProfileBodyWidget extends StatelessWidget {
  const MyProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F1F0),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "이름",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "이메일",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "전화번호",
            ),
          ),
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
                stops: [0.5, 0.5],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Input extends StatelessWidget {
  const Input({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

