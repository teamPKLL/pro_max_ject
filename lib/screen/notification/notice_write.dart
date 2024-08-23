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
      width: double.infinity,

    );
  }
}
