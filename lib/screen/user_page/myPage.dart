import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_service.dart'; // UserService import 추가
import '../../services/profile_service.dart'; // ProfileService import 추가
import '../../models/user_profile.dart'; // Profile import 추가
import 'myProfile.dart'; // 경로를 적절히 수정하세요

class MyPage extends StatelessWidget {
  final UserService _userService = UserService(); // UserService 인스턴스 생성
  final ProfileService _profileService = ProfileService(); // ProfileService 인스턴스 생성

  MyPage({super.key}); // const 제거

  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<String?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F1F0),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: FutureBuilder<String?>(
          future: _getUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No user data found'));
            } else {
              String userId = snapshot.data!;
              return FutureBuilder<Profile?>(
                future: _profileService.getProfileByUserId(userId),
                builder: (context, profileSnapshot) {
                  if (profileSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (profileSnapshot.hasError) {
                    return Center(child: Text('Error: ${profileSnapshot.error}'));
                  } else {
                    Profile profile = profileSnapshot.data ?? Profile(
                      id: null,
                      user_id: userId,
                      name: 'Default Name',
                      email: 'youremail@domain.com',
                      birth: '2000-01-01',
                    );

                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                            width: double.infinity,
                            color: Color(0xFFF0F1F0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      profile.name,
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Text(profile.email),
                                      Text(' | '),
                                      Text(profile.user_id),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ContentBox(
                            children: [
                              ContentIconRow(
                                icon: Icon(Icons.account_circle),
                                text: "Edit Profile Information",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyProfile(userId: profile.user_id)),
                                  );
                                },
                              ),
                              ContentIconRow(
                                icon: Icon(Icons.notifications_none),
                                text: "Notifications",
                                description: "ON",
                              ),
                              ContentIconRow(
                                icon: Icon(Icons.language),
                                text: "Language",
                                description: "English",
                              ),
                            ],
                          ),
                          ContentBox(
                            children: [
                              ContentIconRow(
                                icon: Icon(Icons.info_outline),
                                text: "Help & Support",
                              ),
                              ContentIconRow(
                                icon: Icon(Icons.help_outline),
                                text: "FAQ",
                              ),
                              ContentIconRow(
                                icon: Icon(Icons.textsms_outlined),
                                text: "Contact us",
                              ),
                              ContentIconRow(
                                icon: Icon(Icons.security),
                                text: "Privacy & Policy",
                              ),
                            ],
                          ),
                          ContentBox(
                            children: [
                              ContentIconRow(
                                icon: Icon(Icons.logout_outlined),
                                text: "Log Out",
                                onTap: () async {
                                  await _userService.logoutUser();
                                  Navigator.pushReplacementNamed(context, '/login');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  final List<Widget> children;

  const ContentBox({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class ContentIconRow extends StatelessWidget {
  final String text;
  final Icon icon;
  final String? description;
  final VoidCallback? onTap;

  const ContentIconRow({super.key, required this.icon, required this.text, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: icon,
          ),
          Expanded(child: Text(text)),
          if (description != null) ...[
            Container(
              padding: EdgeInsets.all(5),
              child: Text(description!, style: const TextStyle(color: Colors.blue)),
            ),
          ],
        ],
      ),
    );
  }
}
