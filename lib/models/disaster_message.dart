class DisasterMessage {
  final String msgCn; // 메시지 내용
  final String rcptnRgnNm; // 수신 지역명
  final String crtDt; // 생성일
  final String regYmd; // 등록일
  final String emrgStepNm; // 비상 단계 명칭
  final int sn; // 일련번호
  final String dstSeNm; // 대상 구분명
  final String mdfcnYmd; // 수정일

  DisasterMessage({
    required this.msgCn,
    required this.rcptnRgnNm,
    required this.crtDt,
    required this.regYmd,
    required this.emrgStepNm,
    required this.sn,
    required this.dstSeNm,
    required this.mdfcnYmd,
  });

  factory DisasterMessage.fromJson(Map<String, dynamic> json) {
    return DisasterMessage(
      msgCn: json['MSG_CN'] is List
          ? (json['MSG_CN'] as List).join(' ')
          : json['MSG_CN'].toString(),
      rcptnRgnNm: json['RCPTN_RGN_NM'] ?? '',
      crtDt: json['CRT_DT'] ?? '',
      regYmd: json['REG_YMD'] ?? '',
      emrgStepNm: json['EMRG_STEP_NM'] ?? '',
      sn: json['SN'] ?? 0,
      dstSeNm: json['DST_SE_NM'] ?? '',
      mdfcnYmd: json['MDFCN_YMD'] ?? '',
    );
  }

  @override
  String toString() {
    return 'DisasterMessage(msgCn: $msgCn, rcptnRgnNm: $rcptnRgnNm, crtDt: $crtDt, regYmd: $regYmd, emrgStepNm: $emrgStepNm, sn: $sn, dstSeNm: $dstSeNm, mdfcnYmd: $mdfcnYmd)';
  }
}
