import 'package:flutter/material.dart';
import 'package:pro_max_ject/models/notice.dart';
import 'package:pro_max_ject/services/notice_service.dart'; // NoticeService를 import
import 'package:pro_max_ject/screen/notification/notice_write.dart';
import 'package:pro_max_ject/screen/widget/BaseNoticeBox.dart';

class NoticeAdmin extends StatelessWidget {
  const NoticeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoticeAppBar(title: '공지사항 (Admin)'),
      body: NoticeAdminBodyWidget(),
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
          Navigator.pop(context); // Navigate back to the previous screen
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class NoticeAdminBodyWidget extends StatefulWidget {
  const NoticeAdminBodyWidget({super.key});

  @override
  _NoticeAdminBodyWidgetState createState() => _NoticeAdminBodyWidgetState();
}

class _NoticeAdminBodyWidgetState extends State<NoticeAdminBodyWidget> {
  final NoticeService _service = NoticeService();
  late Future<List<Notice>> _noticesFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotices();
  }

  Future<void> _fetchNotices() async {
    setState(() {
      _noticesFuture = _service.getAllNotices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: const Color(0xFFF0F1F0),
      child: Column(
        children: [
          AddNoticeBtn(onNoticeAdded: _fetchNotices),
          Expanded(
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
                return ListView(
                  children: notices.map((notice) {
                    return AdminNoticeBox(
                      context: context,
                      title: notice.title,
                      content: notice.content,
                      noticeId: notice.id!,
                      fetchNotices: _fetchNotices,
                      service: _service, // NoticeService 인스턴스를 전달
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddNoticeBtn extends StatelessWidget {
  final VoidCallback onNoticeAdded;

  const AddNoticeBtn({
    super.key,
    required this.onNoticeAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      decoration: ShapeDecoration(
        color: Color(0x658BA38A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: IconButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoticeWrite(),
            ),
          );
          onNoticeAdded(); // 공지사항 추가 후 상태 업데이트
        },
        icon: const Icon(Icons.add),
        color: Color(0xFF537052),
      ),
    );
  }
}

class AdminNoticeBox extends BaseNoticeBox {
  final String noticeId;
  final Future<void> Function() fetchNotices;
  final NoticeService service;
  final BuildContext context;

  const AdminNoticeBox({
    Key? key,
    required String title,
    required String content,
    required this.noticeId,
    required this.fetchNotices,
    required this.service,
    required this.context,
  }) : super(key: key, title: title, content: content, theme: Colors.white);

  @override
  List<Widget> extraWidgets() {
    return [
      Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticeWrite(
                        title: title,
                        content: content,
                        id: noticeId,
                      ),
                    ),
                  ).then((_) {
                    fetchNotices(); // 공지사항 수정 후 리스트 갱신
                  });
                },
                icon: const Icon(Icons.edit_note, color: Colors.blue),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () async {
                  try {
                    await service.deleteNotice(noticeId);
                    fetchNotices(); // 삭제 후 리스트 갱신
                  } catch (e) {
                    print('삭제 실패: $e');
                  }
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
