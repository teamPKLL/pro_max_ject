import 'package:firebase_database/firebase_database.dart';
import 'package:pro_max_ject/models/notice.dart';

class NoticeRepository {
  final DatabaseReference _noticesRef = FirebaseDatabase.instance.ref().child('notices');

  // 공지사항 추가
  Future<void> addNotice(Notice notice) async {
    try {
      final newNoticeRef = _noticesRef.push();
      await newNoticeRef.set(notice.toJson());
    } catch (e) {
      print('Failed to add notice: $e');
      throw Exception('공지사항 추가 실패');
    }
  }

  // 공지사항 가져오기
  Future<List<Notice>> getNotices() async {
    try {
      final snapshot = await _noticesRef.once();
      final noticesMap = snapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (noticesMap != null) {
        // Map<dynamic, dynamic>을 Map<String, dynamic>으로 변환
        final List<Notice> notices = noticesMap.entries.map((entry) {
          final key = entry.key as String; // ID
          final value = entry.value as Map<dynamic, dynamic>; // JSON 데이터
          return Notice.fromJson(Map<String, dynamic>.from(value), key);
        }).toList();
        return notices;
      }
      return [];
    } catch (e) {
      print('Failed to fetch notices: $e');
      throw Exception('공지사항 가져오기 실패');
    }
  }

  // 공지사항 업데이트
  Future<void> updateNotice(Notice notice) async {
    if (notice.id != null) {
      try {
        // 'createAt'을 제외한 필드만 업데이트
        final updatedNotice = Notice(
          id: notice.id,
          title: notice.title,
          content: notice.content,
          createAt: notice.createAt, // 기존 'createAt' 유지
          updateAt: DateTime.now(), // 현재 시간으로 'updateAt' 업데이트
        );
        await _noticesRef.child(notice.id!).update(updatedNotice.toJson());
      } catch (e) {
        print('Failed to update notice: $e');
        throw Exception('공지사항 업데이트 실패');
      }
    } else {
      throw ArgumentError('공지사항 ID가 필요합니다.');
    }
  }

  // 공지사항 삭제
  Future<void> deleteNotice(String id) async {
    try {
      await _noticesRef.child(id).remove();
    } catch (e) {
      print('Failed to delete notice: $e');
      throw Exception('공지사항 삭제 실패');
    }
  }
}
