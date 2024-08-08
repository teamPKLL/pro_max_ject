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
          title: Center(child: Text('프로필',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          )),
          backgroundColor: const Color(0xFFF0F1F0),
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
      child: Column(
        children: [
          InputBox(labelText: '이름'),
          InputBox(labelText: '이메일'),
          InputBox(labelText: '전화번호'),
          Row(
            children: [
              Expanded(child: SelectBox()),
              Expanded(child: InputBox(labelText: '생년월일',))
            ],
          ),
          RowInputBox(labelText1: '키', labelText2: '몸무게', gap: 20),
          InputBox(labelText: '주소'),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){},
                    child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}

class InputBox extends StatelessWidget {
  final String labelText;
  const InputBox({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0), // 포커스 시 보더 색상
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          focusColor: Colors.blue,
        ),
        cursorColor: Colors.black,
      ),
    );
  }
}

class RowInputBox extends StatelessWidget {
  final String labelText1;
  final String labelText2;
  final double gap;
  const RowInputBox({
    super.key,
    required this.labelText1,
    required this.labelText2,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: InputBox(labelText: '키')
          ),
          // SizedBox(width: gap), // TextField 사이의 간격
          Expanded(
            child: InputBox(labelText: '몸무게')
          ),
        ],
      ),
    );
  }
}

class SelectBox extends StatefulWidget {
  const SelectBox({super.key});

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  final _bloodType = ['A', 'B', 'O', 'AB'];
  String? _selectedType;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // 테두리 색상
        borderRadius: BorderRadius.circular(5), // 둥근 모서리
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text('혈액형',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          items: _bloodType.map((e) =>
            DropdownMenuItem(
              value: e,
              child: Text(e)
            )
          ).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue!;
            });
          }
        ),
      ),
    );
  }
}



