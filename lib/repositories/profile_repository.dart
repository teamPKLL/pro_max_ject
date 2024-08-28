import 'package:firebase_database/firebase_database.dart';
import 'package:pro_max_ject/models/user_profile.dart';

class ProfileRepository {
  final DatabaseReference _profilesRef = FirebaseDatabase.instance.ref('profiles');

  /// 사용자 ID로 프로필을 가져오는 메서드
  Future<Profile?> getProfileByUserId(String userId) async {
    try {
      // 'profiles' 노드에서 'user_id'가 일치하는 프로필을 검색합니다.
      Query query = _profilesRef.orderByChild('user_id').equalTo(userId);
      DataSnapshot snapshot = await query.get();

      if (snapshot.exists) {
        Map<String, dynamic> data = Map<String, dynamic>.from((snapshot.value as Map).values.first);
        return Profile.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  /// 새로운 프로필을 'profiles' 노드에 추가합니다.
  Future<void> saveProfile(Profile profile) async {
    try {
      DatabaseReference newProfileRef = _profilesRef.push();
      profile.id = newProfileRef.key;
      await newProfileRef.set(profile.toJson());
    } catch (e) {
      print('Error saving profile: $e');
    }
  }

  /// 프로필을 업데이트하는 메서드
  Future<void> updateProfile(Profile profile) async {
    try {
      if (profile.id != null) {
        // 특정 프로필 ID를 가진 프로필을 업데이트합니다.
        DatabaseReference profileRef = _profilesRef.child(profile.id!);
        await profileRef.update(profile.toJson());
      } else if (profile.user_id != null) {
        // 프로필 ID가 없지만 user_id가 있을 때, user_id로 프로필을 찾아 업데이트합니다.
        Query query = _profilesRef.orderByChild('user_id').equalTo(profile.user_id);
        DataSnapshot snapshot = await query.get();

        if (snapshot.exists) {
          String profileId = (snapshot.value as Map).keys.first;
          DatabaseReference profileRef = _profilesRef.child(profileId);
          await profileRef.update(profile.toJson());
        } else {
          print('Profile with user_id ${profile.user_id} not found for update.');
        }
      } else {
        print('Profile ID and user_id are both null. Cannot update profile.');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  /// 프로필을 삭제하는 메서드
  Future<void> deleteProfile(String profileId) async {
    try {
      DatabaseReference profileRef = _profilesRef.child(profileId);
      await profileRef.remove();
    } catch (e) {
      print('Error deleting profile: $e');
    }
  }
}
