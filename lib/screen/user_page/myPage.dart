import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/user_page/myProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_service.dart'; // UserService import 추가

class MyPage extends StatelessWidget {
  final UserService _userService = UserService(); // UserService 인스턴스 생성

  MyPage({super.key}); // const 제거

  // SharedPreferences에서 사용자 이름을 가져오는 메서드
  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F1F0), // 전체 배경 컬러,
        // appBar: AppBar(
        //   title: Text('My Page'),
        //   // AppBar의 actions에 로그아웃 버튼 제거
        // ),
        resizeToAvoidBottomInset : false,
        body: SingleChildScrollView(child: FutureBuilder<String?>(
          future: _getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No user data found'));
            } else {
              String userName = snapshot.data!;
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(  // user description box
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                      width: double.infinity,
                      color: Color(0xF0F1F0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                userName,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                              ),
                              // Container(  // IconButton Wrapper
                              //   decoration: const BoxDecoration(
                              //     color: Colors.white,
                              //     shape: BoxShape.circle,
                              //   ),
                              //   margin: EdgeInsets.all(5),
                              //   child: IconButton(
                              //     onPressed: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(builder: (context) => MyProfile()),
                              //       );
                              //     },
                              //     icon: const Icon(Icons.edit_outlined),
                              //     color: Colors.blue, // 아이콘 색상
                              //     iconSize: 24, // 아이콘 크기
                              //   ),
                              // ),
                            ],
                          ),
                          Container(  // user description content
                            margin: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text('youremail@domain.com'), // 이메일은 실제 사용자 데이터에서 가져와야 함
                                Text(' | '),
                                Text('010-0000-0000'), // 전화번호는 실제 사용자 데이터에서 가져와야 함
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyProfile(username: userName,)),
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
                            await _userService.logoutUser(); // UserService의 logoutUser 메서드 호출
                            Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
        ));
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
      child: Column( // Container Contents
        children: children,
      ),
    );
  }
}

class ContentIconRow extends StatelessWidget {
  final String text;
  final Icon icon;
  final String? description;
  final VoidCallback? onTap; // onTap 콜백 추가

  const ContentIconRow({super.key, required this.icon, required this.text, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(5),
              child: icon
          ),
          Expanded(child: Text(text)),
          if (description != null) ...[
            Container(
                padding: EdgeInsets.all(5),
                child: Text(description!, style: const TextStyle(color: Colors.blue),)
            ),
          ],
        ],
      ),
    );
  }
}
