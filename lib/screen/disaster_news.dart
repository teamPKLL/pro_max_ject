
import 'package:flutter/material.dart';
import 'package:pro_max_ject/api/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:pro_max_ject/models/disaster_news.dart';

class DisasterNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch news when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DisasterNewsProvider>(context, listen: false).fetchNews();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('재난 뉴스'),
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
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Text(
                  news.ynaTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.ynaContent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        news.ynaRegDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(news: news),
                    ),
                  );
                },
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '작성자: ${news.ynaWriterName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8.0),
            Text(
              '등록일시: ${news.ynaRegDate}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 16.0),
            Text(news.ynaContent),
          ],
        ),
      ),
    );
  }
}
