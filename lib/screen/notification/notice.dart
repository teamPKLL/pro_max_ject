import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/widget/BaseNoticeBox.dart';
import 'package:provider/provider.dart';

import '../widget/IndexProvider.dart';
import '../widgetmain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Notice());
}

class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: Scaffold(
        appBar: NoticeAppBar(title: '공지사항',),
        body: NoticeBodyWidget(),
      ),
    );
  }
}

class NoticeAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  const NoticeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(title,
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
          context.read<IndexProvider>().setIndex(1);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>FigmaToCodeApp()),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class NoticeBodyWidget extends StatelessWidget {
  const NoticeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      color: const Color(0xFFF0F1F0),
      child: ListView(
        children: [
          NormalNoticeBox(
              title: '테스트',
              content: '테스트 내용입니다. 더 상세한 내용은 안녕하세요 입니다. 이게 무슨 말인지는 모르겠고 그냥 이것 저것 나열하는 중입니다. 이 정도 길이면 충분하지 않을까요'
          ),
          NormalNoticeBox(
            title: 'main 공지',
            content: '색깔이 달라요. 좀 더 강조되는 효과가 있겠죠. 또한 하나 정도라도 있다면 미적으로 좋아 보일 수 있습니다. 왜냐하면 Main Theme Color를 사용했기 때문인데요. 이로 인해 사용자는 더 통일된 디자인을 경험하게 됩니다.',
            theme: Color(0xFF537052),
          ),
          NormalNoticeBox(
            title: 'main 공지',
            content: '색깔이 달라요. 좀 더 강조되는 효과가 있겠죠. 또한 하나 정도라도 있다면 미적으로 좋아 보일 수 있습니다. 왜냐하면 Main Theme Color를 사용했기 때문인데요. 이로 인해 사용자는 더 통일된 디자인을 경험하게 됩니다.',
            theme: Colors.white,
          ),
        ],
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
      SizedBox(height: 15, width: double.infinity,)
    ];
  }}