import 'package:flutter/material.dart';

void main() {
  runApp(FAQList());
}

class FAQList extends StatelessWidget {
  const FAQList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: FAQScreen(),
    );
  }
}

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F1F0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16),
            color: Color(0xFFF0F1F0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Handle back button tap
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'FAQ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BM_HANNA_TTF',
                  ),
                ),
                SizedBox(width: 24), // Spacer
              ],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                FAQItem(
                  question: '질문 1',
                  answer:
                  '답변 1입니다. 답변은 접혀 있을 때와 펼쳐질 때의 상태를 가집니다.',
                ),
                FAQItem(
                  question: '질문 2',
                  answer:
                  '답변 2입니다. 여기에는 질문에 대한 자세한 설명이 들어갈 수 있습니다.',
                ),
                FAQItem(
                  question: '질문 3',
                  answer:
                  '답변 3입니다. 추가적인 정보나 링크를 포함할 수도 있습니다.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: ExpansionTile(
        collapsedBackgroundColor: Color(0xFFF0F1F0),
        backgroundColor: Color(0xFFF0F1F0),
        title: Text(
          widget.question,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.answer,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
