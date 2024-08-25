import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class MyProfile extends StatelessWidget {
  final String username;
  const MyProfile({super.key, required this.username});

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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: MyProfileBodyWidget(username: username,),
      )
    );
  }
}

class MyProfileBodyWidget extends StatelessWidget {
  final String username;
  const MyProfileBodyWidget({super.key, required this.username});

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
                Text(username, // 회원 이름의 최종 목적지..
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
          // 각 Input Box에는 innerValue와 controller를 파라미터로 받을 수 있음
          // innerValue는 기존 회원 정보를 불러 올 때 사용할 수 있다.
          // controller는 '완료' 버튼을 누를 때 저장하기 위한 장치이다.
          InputBox(labelText: '이름', innerValue: '홍길동',),
          InputBox(labelText: '전화번호'),
          InputBox(labelText: '생년월일'),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("※ 위 개인정보는 구조 신호를 보낼 때 더 빠른 구조와 신원 확인을 위해 사용됩니다.")
          ),
          TextBtn(text: '완료', onPressed: (){}, theme: true,),
          TextBtn(
            text: '취소',
            onPressed: (){
              print('TextBtn onPressed called');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  final String? innerValue;
  final TextEditingController? controller; // 외부에서 컨트롤러를 제공할 수 있도록 함
  final String labelText;
  const InputBox({
    super.key,
    required this.labelText,
    this.innerValue,
    this.controller,
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  // final TextEditingController _controller = TextEditingController();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 외부에서 제공된 컨트롤러를 사용하거나, 초기 값으로 컨트롤러를 생성
    _controller = widget.controller ?? TextEditingController(text: widget.innerValue ?? '');
  }

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
        onPressed: (){
          print('TextButton pressed'); // 콜백 호출 여부를 확인
          onPressed();
        },
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
