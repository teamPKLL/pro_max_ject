import 'dart:ui';

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
        appBar: AppBar(
          title:  Text('프로필',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'BM_HANNA_TTF',
              )),
          centerTitle : true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xEF537052),
          elevation: 4,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
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
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Text('user',
                  style: TextStyle(
                    fontFamily: 'BM_HANNA_TTF',
                    fontSize: 20,
                  ),
                ),
                Text('님의 회원 정보',
                  style: TextStyle(
                    fontFamily: 'BM_HANNA_TTF',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          InputBox(labelText: '이름'),
          InputBox(labelText: '전화번호'),
          InputBox(labelText: '생년월일'),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("※ 위 개인정보는 구조 신호를 보낼 때 더 빠른 구조와 신원 확인을 위해 사용됩니다.")
          ),
          TextBtn(text: '완료', onPressed: (){}, theme: true,),
          TextBtn(text: '취소', onPressed: (){}, ),
        ],
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  final String labelText;
  const InputBox({super.key, required this.labelText});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF537052),
              width: 2.0,
            ),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.grey),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF537052), // 활성화(포커스) 상태에서의 labelText 색상
          ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }
}

class TextBtn extends StatelessWidget {
  final String text;
  final bool theme;
  final VoidCallback onPressed;
  const TextBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.theme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: (theme) ? const Color(0xFF537052) : const Color(0xFFF0F1F0),
        border: Border.all(
          color: const Color(0xFF537052),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
          style: TextStyle(
            color: theme ? Colors.white : const Color(0xFF537052),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
