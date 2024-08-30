class Notice {
  final String? id;
  final String title;
  final String content;
  final DateTime createAt;
  final DateTime updateAt;

  Notice({
    this.id,
    required this.title,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  // JSON에서 Notice 객체를 생성
  factory Notice.fromJson(Map<String, dynamic> json, String id) {
    return Notice(
      id: id,
      title: json['title'] as String,
      content: json['content'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
    );
  }

  // Notice 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'createAt': createAt.toIso8601String(),
    'updateAt': updateAt.toIso8601String(),
  };
}
