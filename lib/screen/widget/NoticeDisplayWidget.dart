import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/notification/notice_user.dart';
import 'package:pro_max_ject/screen/notification/notice_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 사용자 정보를 가져오는 함수
Future<bool> getIsAdminStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAdmin') ?? false; // isAdmin이 null일 경우 기본값은 false
}

class NoticeDisplayWidget extends StatefulWidget {
  final List<String> strings;
  final Duration displayDuration;
  final Duration fadeDuration;
  final BuildContext context;
  final double width;
  final double height;

  const NoticeDisplayWidget({
    super.key,
    required this.strings,
    this.displayDuration = const Duration(seconds: 3),
    this.fadeDuration = const Duration(milliseconds: 500),
    required this.context,
    required this.width,
    required this.height,
  });

  @override
  State<NoticeDisplayWidget> createState() => _NoticeDisplayWidgetState();
}

class _NoticeDisplayWidgetState extends State<NoticeDisplayWidget> {
  int currentIndex = 0;
  Timer? timer;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    if (widget.strings.isNotEmpty) {
      // 리스트가 비어있지 않을 때만 타이머 시작
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool isAdmin = await getIsAdminStatus(); // isAdmin 상태 확인
        if (isAdmin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoticeAdmin()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoticeUserPage()),
          );
        }
      },
      child: Container(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: widget.fadeDuration,
          child: Text(
            widget.strings[currentIndex],
            key: ValueKey<String>(widget.strings[currentIndex]),
            style: TextStyle(
              fontFamily: 'BM_HANNA_TTF',
              fontSize: 15,
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(18, 10, 18, 8),
        width: widget.width * 0.9,
        height: widget.height * 0.05,
        margin: EdgeInsets.symmetric(horizontal: widget.width * 0.04),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(widget.displayDuration, (Timer t) {
      setState(() {
        opacity = 0.0; // 텍스트를 서서히 사라지게 함
      });

      Future.delayed(widget.fadeDuration, () {
        setState(() {
          currentIndex = (currentIndex + 1) % widget.strings.length;
          opacity = 1.0; // 새로운 텍스트를 서서히 나타나게 함
        });
      });
    });
  }
}
