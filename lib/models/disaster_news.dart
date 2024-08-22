class DisasterNews {
  final String ynaNo;          // 연합뉴스번호
  final String ynaTitle;        // 연합뉴스제목
  final String ynaContent;      // 연합뉴스내용
  final String ynaYmd;          // 연합뉴스일자
  final String ynaWriterName;   // 연합뉴스작성자명
  final String crtDate;         // 생성일시

  DisasterNews({
    required this.ynaNo,
    required this.ynaTitle,
    required this.ynaContent,
    required this.ynaYmd,
    required this.ynaWriterName,
    required this.crtDate,
  });

  factory DisasterNews.fromJson(Map<String, dynamic> json) {
    return DisasterNews(
      ynaNo: (json['YNA_NO'] is String) ? json['YNA_NO'] as String : json['YNA_NO'].toString(),
      ynaTitle: (json['YNA_TTL'] as String?) ?? '',
      ynaContent: (json['YNA_CN'] as String?) ?? '',
      ynaYmd: (json['YNA_YMD'] as String?) ?? '',
      ynaWriterName: (json['YNA_WRTR_NM'] as String?) ?? '',
      crtDate: (json['CRT_DT'] as String?) ?? '',
    );
  }

  @override
  String toString() {
    return 'DisasterNews(ynaNo: $ynaNo, ynaTitle: $ynaTitle, ynaContent: $ynaContent, ynaYmd: $ynaYmd, ynaWriterName: $ynaWriterName, crtDate: $crtDate)';
  }
}
