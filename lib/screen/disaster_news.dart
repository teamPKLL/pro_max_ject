import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pro_max_ject/api/news_provider.dart';
import 'package:pro_max_ject/models/disaster_news.dart';

class DisasterNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch news when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DisasterNewsProvider>(context, listen: false).fetchNews();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F0),
      appBar: AppBar(
        title: Text(
            '재난 뉴스',
            style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
        ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xEF537052),
        elevation: 4,
      ),
      body: Consumer<DisasterNewsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }

          if (provider.newsList.isEmpty) {
            return Center(child: Text('뉴스가 없습니다.'));
          }

          return ListView.builder(
            itemCount: provider.newsList.length,
            itemBuilder: (context, index) {
              final news = provider.newsList[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(news: news),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.ynaTitle,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          news.ynaContent,
                          maxLines: 1, // 한 줄만 표시
                          overflow: TextOverflow.ellipsis, // 넘치는 부분은 생략 표시
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            news.ynaYmd, // 연합뉴스일자 필드 표시
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[500],
                              // fontFamily: 'BM_HANNA_TTF',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final DisasterNews news;

  const NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.ynaTitle),
        backgroundColor: Color(0xFF537052), // 연녹색으로 변경
      ),
      backgroundColor: Color(0xFFF0F1F0),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 뉴스 작성자와 등록일시 정보
              Text(
                '작성자: ${news.ynaWriterName}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '등록일시: ${news.crtDate}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),

              // 뉴스 내용
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4), // 그림자 위치
                    ),
                  ],
                ),
                child: Text(
                  news.ynaContent,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
