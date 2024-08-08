import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(backgroundColor: Color(0xEF537052)),
        body: const BodyWidget(),
        // bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // BODY WIDGET
      padding: EdgeInsets.all(20),
      child: Column( // entire UI vertical drop
        children: [
          Container(  // user description box
            padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
            width: double.infinity,
            color: Color(0xF0F1F0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text('회원명1',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                      Container(  // IconButton Wrapper
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      )
                    ],
                  ),
                ),
                Container(  // user description content
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text('youremail@domain.com'),
                      Text(' | '),
                      Text('010-0000-0000'),
                    ],
                  ),
                )
              ],
            ),
          ),
          ContentBox(
            children: [
              ContentIconRow(icon: Icon(Icons.account_circle), text: "Edit Profile Information"),
              ContentIconRow(icon: Icon(Icons.notifications_none), text: "Notifications", description: "ON"),
              ContentIconRow(icon: Icon(Icons.language), text: "Language", description: "English")
            ],
          ),
          ContentBox(
            children: [
              ContentIconRow(icon: Icon(Icons.help), text: "Help & Support"),
              ContentIconRow(icon: Icon(Icons.textsms_outlined), text: "Contact us"),
              ContentIconRow(icon: Icon(Icons.security), text: "Privacy & Policy"),
            ]
          ),
          ContentBox(children: [
            ContentIconRow(icon: Icon(Icons.logout_outlined), text: "Log Out"),
          ]
          )
        ],
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  final List<Widget> children;

  const ContentBox({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column( // Container Contents
        children: children,
      ),
    );
  }
}

class ContentIconRow extends StatelessWidget {

  final String text;
  final Icon icon;
  final String? description;

  const ContentIconRow({super.key, required this.icon, required this.text, this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                child: icon
            ),
            Expanded(child: Text(text)),
            if(description != null) ...[
              Container(
                  padding: EdgeInsets.all(5),
                  child: Text(description!, style: const TextStyle(color: Colors.blue),)
              )
            ]
          ]
      ),
    );
  }
}


