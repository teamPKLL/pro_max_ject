import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 표시 제거
      home: Scaffold(
        backgroundColor: Color(0xFFF0F1F0),
        appBar: AppBar(
          title: Text(
            '개발자 연락처',
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
        body: ContactUsBodyWidget(),
      ),
    );
  }
}

final TextStyle myTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

class ContactUsBodyWidget extends StatelessWidget {
  const ContactUsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("이현준 : 202244111@itc.ac.kr", style: myTextStyle,)
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("박민제 : alswp202044059@gamil.com", style: myTextStyle,)
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("김나희 : 202344055@itc.ac.kr", style: myTextStyle,)
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("이정준 : jungjune276@gmail.com", style: myTextStyle,)
          ),
        ],
      ),
    );
  }
}
