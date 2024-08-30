import 'package:pro_max_ject/models/notice.dart';
import 'package:pro_max_ject/repositories/notice_repository.dart';

class NoticeService {
  final NoticeRepository _repository = NoticeRepository();

  Future<void> createNotice(String title, String content) async {
    final notice = Notice(
      title: title,
      content: content,
      createAt: DateTime.now(), // 공지사항 생성 시간
      updateAt: DateTime.now(), // 공지사항 생성 시간과 동일하게 설정
    );
    await _repository.addNotice(notice);
  }

  Future<List<Notice>> getAllNotices() async {
    List<Notice> notices = await _repository.getNotices();
    // 시간 순으로 정렬
    notices.sort((a, b) => b.updateAt.compareTo(a.updateAt));
    return notices;
  }

  Future<List<String>> getRecentNoticeTitles(int count) async {
    List<Notice> notices = await getAllNotices();
    // 최근 `count`개의 공지사항 제목만 추출
    return notices.take(count).map((notice) => notice.title).toList();
  }

  Future<void> updateNotice(String id, String title, String content) async {
    // 기존 공지사항을 가져와서 업데이트
    final notices = await _repository.getNotices();
    final notice = notices.firstWhere((n) => n.id == id, orElse: () => throw ArgumentError('공지사항이 없습니다.'));

    final updatedNotice = Notice(
      id: id,
      title: title,
      content: content,
      createAt: notice.createAt, // 기존의 'createAt' 유지
      updateAt: DateTime.now(),  // 현재 시간으로 'updateAt' 업데이트
    );
    await _repository.updateNotice(updatedNotice);
  }

  Future<void> deleteNotice(String id) async {
    await _repository.deleteNotice(id);
  }
}
