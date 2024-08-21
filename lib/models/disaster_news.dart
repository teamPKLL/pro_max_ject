class DisasterNews {
  final String ynaNo;
  final String ynaTitle;
  final String ynaWriterName;
  final String teamName;
  final String ynaRegDate;
  final String crtDate;
  final String exposureYn;
  final String alarmYn;
  final String deleteYn;
  final String ynaContent;

  DisasterNews({
    required this.ynaNo,
    required this.ynaTitle,
    required this.ynaWriterName,
    required this.teamName,
    required this.ynaRegDate,
    required this.crtDate,
    required this.exposureYn,
    required this.alarmYn,
    required this.deleteYn,
    required this.ynaContent,
  });

  factory DisasterNews.fromJson(Map<String, dynamic> json) {
    return DisasterNews(
      ynaNo: (json['YNA_NO'] is String) ? json['YNA_NO'] as String : json['YNA_NO'].toString(),
      ynaTitle: (json['YNA_TTL'] as String?) ?? '',
      ynaWriterName: (json['YNA_WRTR_NM'] as String?) ?? '',
      teamName: (json['TEAM_NM'] as String?) ?? '',
      ynaRegDate: (json['YNA_REG_YMD'] as String?) ?? '',
      crtDate: (json['CRT_DT'] as String?) ?? '',
      exposureYn: (json['EXPSR_YN'] as String?) ?? '',
      alarmYn: (json['ALRM_YN'] as String?) ?? '',
      deleteYn: (json['DEL_YN'] as String?) ?? '',
      ynaContent: (json['YNA_CN'] as String?) ?? '',
    );
  }

  @override
  String toString() {
    return 'DisasterNews(ynaNo: $ynaNo, ynaTitle: $ynaTitle, ynaWriterName: $ynaWriterName, teamName: $teamName, ynaRegDate: $ynaRegDate, crtDate: $crtDate, exposureYn: $exposureYn, alarmYn: $alarmYn, deleteYn: $deleteYn, ynaContent: $ynaContent)';
  }
}
