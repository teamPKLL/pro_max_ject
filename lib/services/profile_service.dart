import 'package:pro_max_ject/models/user_profile.dart';
import 'package:pro_max_ject/repositories/profile_repository.dart';

class ProfileService {
  final ProfileRepository _profileRepository = ProfileRepository();

  Future<Profile?> getProfileByUserId(String userId) async {
    try {
      return await _profileRepository.getProfileByUserId(userId);
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await _profileRepository.updateProfile(profile);
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> deleteProfile(String profileId) async {
    try {
      await _profileRepository.deleteProfile(profileId);
    } catch (e) {
      print('Error deleting profile: $e');
    }
  }
}
