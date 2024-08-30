import 'package:flutter/material.dart';
import 'package:pro_max_ject/repositories/notice_repository.dart';
import 'package:pro_max_ject/models/notice.dart';
import 'package:pro_max_ject/screen/widget/BaseNoticeBox.dart';
import 'package:pro_max_ject/screen/widget/IndexProvider.dart';
import 'package:pro_max_ject/screen/widgetmain.dart';
import 'package:provider/provider.dart';

class NoticeUserPage extends StatelessWidget {
  const NoticeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoticeAppBar(title: '공지사항'),
      body: NoticeBodyWidget(),
    );
  }
}

class NoticeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NoticeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
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
          context.read<IndexProvider>().setIndex(1);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FigmaToCodeApp()),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class NoticeBodyWidget extends StatefulWidget {
  const NoticeBodyWidget({super.key});

  @override
  _NoticeBodyWidgetState createState() => _NoticeBodyWidgetState();
}

class _NoticeBodyWidgetState extends State<NoticeBodyWidget> {
  final NoticeRepository _repository = NoticeRepository();
  late Future<List<Notice>> _noticesFuture;

  @override
  void initState() {
    super.initState();
    _noticesFuture = _fetchNotices();
  }

  Future<List<Notice>> _fetchNotices() async {
    List<Notice> notices = await _repository.getNotices();
    // 시간 순으로 정렬
    notices.sort((a, b) => b.createAt.compareTo(a.createAt));
    return notices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      color: const Color(0xFFF0F1F0),
      child: FutureBuilder<List<Notice>>(
        future: _noticesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('공지사항이 없습니다.'));
          }

          final notices = snapshot.data!;
          return ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];
              // 최신 공지사항은 초록색, 나머지는 하얀색
              final boxColor = index == 0 ? Color(0xFF537052) : Colors.white;

              return NormalNoticeBox(
                title: notice.title,
                content: notice.content,
                theme: boxColor,
              );
            },
          );
        },
      ),
    );
  }
}

class NormalNoticeBox extends BaseNoticeBox {
  const NormalNoticeBox({
    Key? key,
    required String title,
    required String content,
    Color theme = Colors.white,
  }) : super(key: key, title: title, content: content, theme: theme);

  @override
  List<Widget> extraWidgets() {
    return [
      SizedBox(height: 15, width: double.infinity,),
    ];
  }
}
