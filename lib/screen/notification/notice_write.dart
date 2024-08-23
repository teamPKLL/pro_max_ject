import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/notification/notice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NoticeWrite());
}

class NoticeWrite extends StatelessWidget {
  const NoticeWrite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: NoticeAppBar(title: '공지사항 (Admin)',),
        body: NoticeWriteBodyWidget(),
      ),
    );
  }
}

class NoticeWriteBodyWidget extends StatelessWidget {
  const NoticeWriteBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F1F0),
      width: double.infinity,
      child: ListView(
        children: [
          TitleInputBox(),
          ContentInputBox(),
          RowDate(property: 'createdAt', value: '20240823'),
          RowDate(property: 'updatedAt', value: '20240823'),
          TextBtnWidthInfinity(text: '저장', theme: true,),
          TextBtnWidthInfinity(text: '취소', ),
        ],
      ),
    );
  }
}

class TitleInputBox extends StatefulWidget {
  const TitleInputBox({super.key});

  @override
  State<TitleInputBox> createState() => _TitleInputBoxState();
}

class _TitleInputBoxState extends State<TitleInputBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'title',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
          ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF537052), // 포커스될 때의 테두리 색상
                width: 2.0,
              ),
            ),
        ),
      )
    );
  }
}

class ContentInputBox extends StatefulWidget {
  const ContentInputBox({super.key});

  @override
  State<ContentInputBox> createState() => _ContentInputBoxState();
}

class _ContentInputBoxState extends State<ContentInputBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Content',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF537052), // 포커스될 때의 테두리 색상
                width: 2.0,
              ),
            ),
          ),
        )
    );
  }
}

class RowDate extends StatelessWidget {
  final String property;
  final String value;
  final double fontSize;
  const RowDate({
    super.key,
    required this.property,
    required this.value,
    this.fontSize = 20.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
      width: double.infinity,

      child: Row(
        children: [
          Text(property,
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
          Text(' : ',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
          Text(value,
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

class TextBtnWidthInfinity extends StatelessWidget {
  final String text;
  final bool theme;
  const TextBtnWidthInfinity({
    super.key,
    required this.text,
    this.theme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
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
        onPressed: () {},
        child: Text(text,
          style: TextStyle(
            color: theme ? Colors.white : const Color(0xFF537052),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

