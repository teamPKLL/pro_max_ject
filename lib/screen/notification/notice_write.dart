import 'package:flutter/material.dart';
import 'package:pro_max_ject/services/notice_service.dart';
import 'package:pro_max_ject/models/notice.dart';

class NoticeWrite extends StatelessWidget {
  final String? title;
  final String? content;
  final String? id;

  const NoticeWrite({
    super.key,
    this.title,
    this.content,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          id == null ? '공지사항 추가' : '공지사항 수정',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        centerTitle: true,
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
      body: NoticeWriteBodyWidget(
        title: title,
        content: content,
        id: id,
        context: context,
      ),
    );
  }
}

class NoticeWriteBodyWidget extends StatefulWidget {
  final BuildContext context;
  final String? title;
  final String? content;
  final String? id;

  const NoticeWriteBodyWidget({
    super.key,
    this.title,
    this.content,
    this.id,
    required this.context,
  });

  @override
  _NoticeWriteBodyWidgetState createState() => _NoticeWriteBodyWidgetState();
}

class _NoticeWriteBodyWidgetState extends State<NoticeWriteBodyWidget> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final NoticeService _service = NoticeService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title ?? '');
    _contentController = TextEditingController(text: widget.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F1F0),
      width: double.infinity,
      child: ListView(
        children: [
          TitleInputBox(controller: _titleController),
          ContentInputBox(controller: _contentController),
          RowDate(property: 'Created At', value: '2024-08-23'),
          RowDate(property: 'Updated At', value: '2024-08-23'),
          TextBtnWidthInfinity(
            text: '저장',
            onPressed: () async {
              final title = _titleController.text;
              final content = _contentController.text;

              try {
                if (widget.id == null) {
                  // 새 공지사항 추가
                  await _service.createNotice(title, content);
                } else {
                  // 기존 공지사항 수정
                  await _service.updateNotice(widget.id!, title, content);
                }

                // 저장 성공 후 노티스 어드민 페이지로 돌아가기
                Navigator.pop(context); // 노티스 어드민 페이지로 돌아가기
              } catch (e) {
                // 오류 처리
                print('Failed to add/update notice: $e');
              }
            },
            theme: true,
          ),
          TextBtnWidthInfinity(
            text: '취소',
            onPressed: () {
              Navigator.pop(context); // 현재 페이지 닫기
            },
          ),
        ],
      ),
    );
  }
}

class TitleInputBox extends StatelessWidget {
  final TextEditingController controller;
  const TitleInputBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
      child: TextField(
        controller: controller,
        cursorColor: const Color(0xFF537052),
        decoration: InputDecoration(
          labelText: '제목',
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF537052),
          ),
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
        ),
      ),
    );
  }
}

class ContentInputBox extends StatelessWidget {
  final TextEditingController controller;
  const ContentInputBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
      child: TextField(
        controller: controller,
        cursorColor: const Color(0xFF537052),
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: '내용',
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
        ),
      ),
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
    this.fontSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
      width: double.infinity,
      child: Row(
        children: [
          Text(
            property,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
          Text(
            ' : ',
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
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
        color: theme ? const Color(0xFF537052) : const Color(0xFFF0F1F0),
        border: Border.all(
          color: const Color(0xFF537052),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
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
