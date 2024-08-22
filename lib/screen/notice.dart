import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/widget/IndexProvider.dart';
import 'package:pro_max_ject/screen/widgetmain.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          title: const Center(child: Text('공지사항')),
          backgroundColor: const Color(0xFFF0F1F0),

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
        ),
        body: NoticeBodyWidget(),
      ),
    );
  }
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
          NoticeBox(
              title: '테스트',
              content: '테스트 내용입니다. 더 상세한 내용은 안녕하세요 입니다. 이게 무슨 말인지는 모르겠고 그냥 이것 저것 나열하는 중입니다. 이 정도 길이면 충분하지 않을까요'
          ),
          NoticeBox(
            title: 'main 공지',
            content: '색깔이 달라요. 좀 더 강조되는 효과가 있겠죠. 또한 하나 정도라도 있다면 미적으로 좋아 보일 수 있습니다. 왜냐하면 Main Theme Color를 사용했기 때문인데요. 이로 인해 사용자는 더 통일된 디자인을 경험하게 됩니다.',
            theme: Color(0xFF537052),
          ),
          NoticeBox(
            title: 'main 공지',
            content: '색깔이 달라요. 좀 더 강조되는 효과가 있겠죠. 또한 하나 정도라도 있다면 미적으로 좋아 보일 수 있습니다. 왜냐하면 Main Theme Color를 사용했기 때문인데요. 이로 인해 사용자는 더 통일된 디자인을 경험하게 됩니다.',
            theme: Colors.white,
          ),
        ],
      ),
    );
  }
}

class NoticeBox extends StatefulWidget {
  final String content;
  final String title;
  final Color theme;

  const NoticeBox({
    super.key,
    required this.title,
    required this.content,
    this.theme = Colors.white,
  });

  @override
  State<NoticeBox> createState() => _NoticeBoxState();
}

class _NoticeBoxState extends State<NoticeBox> {
  bool _isOpen = false;
  double _angle = 0.0;

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _iconRotate() {
    setState(() {
      _angle = (_angle == 0) ? -0.25 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40, // 화면 너비에서 padding을 제외한 너비
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      decoration: ShapeDecoration(
        color: widget.theme,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: (widget.theme == Colors.white) ? Colors.black : Colors.white,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: AnimatedRotation(
                  duration: Duration(milliseconds: 200),
                  turns: _angle,
                  curve: Curves.easeInOut,
                  child: Icon(Icons.arrow_back_ios_new, size: 15),
                ),
                color: (widget.theme == Colors.white) ? Colors.black : Colors.white,
                onPressed: () {
                  _toggleOpen();
                  _iconRotate();
                },
              ),
            ],
          ),
          Divider(
            color: (widget.theme == Colors.white) ? Color(0xFFD4D4D4) : Color(0xFF8BA38A),
            thickness: 2,
            height: 20,
          ),
          Text(
            _isOpen ? widget.content : widget.content.substring(0, 25) + '...',
            style: TextStyle(
              color: (widget.theme == Colors.white) ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}