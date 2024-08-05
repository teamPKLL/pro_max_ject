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
        appBar: AppBar(backgroundColor: Colors.lightGreen,),
        body: const BodyWidget(),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('회원명1'),
                    Icon(Icons.edit_outlined)
                  ],
                ),
                Row(
                  children: [
                    Text('youremail@domain.com'),
                    Text('|'),
                    Text('010-0000-0000'),
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}

