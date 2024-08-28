import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NoticeWrite());
}

class NoticeWrite extends StatelessWidget {
  final String? title;
  final String? content;
  const NoticeWrite({
    super.key,
    this.title = null,
    this.content = null,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text('공지사항 (Admin)',
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
        body: NoticeWriteBodyWidget(title: title, content: content, context: context,),
      ),
    );
  }
}

class NoticeWriteBodyWidget extends StatelessWidget {
  final BuildContext context;
  final String? title;
  final String? content;
  const NoticeWriteBodyWidget({
    super.key,
    this.title = null,
    this.content = null,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F1F0),
      width: double.infinity,
      child: ListView(
        children: [
          TitleInputBox(innerValue: title,),
          ContentInputBox(innerValue: content,),
          RowDate(property: 'createdAt', value: '20240823'),
          RowDate(property: 'updatedAt', value: '20240823'),
          TextBtnWidthInfinity(text: '저장', onPressed: (){
            // ********** 저장 로직 ************
            // 각 text field의 값을 빼올 수 있도록 controller 파라미터도 만들었습니다
            // ******************************
            // TODO

          }, theme: true,),
          TextBtnWidthInfinity(
            text: '취소',
            onPressed: (){
              Navigator.pop(this.context);
            },
          ),
        ],
      ),
    );
  }
}

class TitleInputBox extends StatefulWidget {
  final String? innerValue;
  final TextEditingController? controller;
  const TitleInputBox({
    super.key,
    this.innerValue,
    this.controller,
  });



  @override
  State<TitleInputBox> createState() => _TitleInputBoxState();
}

class _TitleInputBoxState extends State<TitleInputBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
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
      padding: EdgeInsets.zero,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
      child: TextField(
        controller: _controller,
        cursorColor: const Color(0xFF537052),
        decoration: InputDecoration(
          labelText: 'title',
          labelStyle: const TextStyle(
            color: Colors.grey, // 기본 상태의 labelText 색상
          ),
          floatingLabelStyle: const TextStyle(
            color: const Color(0xFF537052), // 활성화(포커스) 상태에서의 labelText 색상
          ),
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
  final String? innerValue;
  final TextEditingController? controller;
  const ContentInputBox({
    super.key,
    this.innerValue,
    this.controller,
  });

  @override
  State<ContentInputBox> createState() => _ContentInputBoxState();
}

class _ContentInputBoxState extends State<ContentInputBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
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
        padding: EdgeInsets.zero,
        margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
        child: TextField(
          cursorColor: const Color(0xFF537052),
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
  final VoidCallback onPressed;
  const TextBtnWidthInfinity({
    super.key,
    required this.text,
    required this.onPressed,
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
        onPressed: onPressed,
        child: Text(text,
          style: TextStyle(
            color: theme ? Colors.white : const Color(0xFF537052),
            fontSize: 17,
          ),
        ),
        style: TextButton.styleFrom(
          overlayColor: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}

