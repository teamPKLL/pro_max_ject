import 'package:flutter/material.dart';

abstract class BaseNoticeBox extends StatefulWidget {
  final String content;
  final String title;
  final Color theme;

  const BaseNoticeBox({
    Key? key,
    required this.title,
    required this.content,
    this.theme = Colors.white,
  }) : super(key: key);

  @override
  State<BaseNoticeBox> createState() => _BaseNoticeBoxState();

  List<Widget> extraWidgets();
}

class _BaseNoticeBoxState extends State<BaseNoticeBox> {
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
      // padding: EdgeInsets.only(bottom: 10) ,
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
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: (widget.theme == Colors.white) ? Colors.black : Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: IconButton(
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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              color: (widget.theme == Colors.white) ? Color(0xFFD4D4D4) : Color(0xFF8BA38A),
              thickness: 2,
              height: 20,

            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Text(
              _isOpen ? widget.content : widget.content.substring(0, 20) + '...',
              style: TextStyle(
                color: (widget.theme == Colors.white) ? Colors.black : Colors.white,
              ),
            ),
          ),
          ...widget.extraWidgets(),
        ],
      ),
    );
  }
}