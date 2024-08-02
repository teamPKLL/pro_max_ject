// import 'package:flutter/material.dart';
//
// // Main application class
// class FigmaToCodeApp extends StatelessWidget {
//   const FigmaToCodeApp({super.key});
//
//   class _TestViewState extends State<TestView>
//   with SingleTickerProviderStateMixin {
//
//     TabController _tabController;
//     int _selectedIndex = 0;
//
//   @override
//   void initState() {
//       super.initState();
//       _tabController = TabController(length: 3, vsync: this);
//       _tabController.addListener(
//   () => setState(() => _selectedIndex = _tabController.index));
//   }
//   //
//   @override
//   void dispose(){
//       _tabController.dispose();
//       super.dispose();
//
//   }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
//       ),
//       home: Scaffold(
//         backgroundColor: Color(0xFFF0F1F0), // 전체 배경 컬러
//         appBar: AppBar(
//           title: const Text(
//             '이재난녕',
//             style: TextStyle(
//               color: Colors.white,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           backgroundColor: Color(0xEF537052),
//           elevation: 4,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.notifications, color: Colors.white),
//               onPressed: () {
//                 // Handle notification action
//               },
//             ),
//           ],
//         ),
//         bottomNavigationBar: SizedBox(
//           height: 70,
//           child: TabBar(
//             controller: _tabController,
//             tabs: [
//               Tab(
//                 icon: Icon(
//                   Icons.home,
//                 ),
//               )
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 420,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage("https://via.placeholder.com/420x420"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0x30000000),
//                         blurRadius: 4,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
//                         style: TextStyle(
//                           color: Color(0xFF24252C),
//                           fontSize: 11,
//                           fontFamily: 'Lexend Deca',
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
//                         style: TextStyle(
//                           color: Color(0xFF24252C),
//                           fontSize: 11,
//                           fontFamily: 'Lexend Deca',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 135,
//                       height: 5,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFB8BFC8),
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // 맵 위젯
// // class MapWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: Color(0xFFF0F1F0), // 배경 색상
// //       ),
// //       child: Stack(
// //         children: [
// //           Positioned(
// //             top: 72,
// //             left: -13,
// //             child: Container(
// //               width: 420,
// //               height: 420,
// //               decoration: BoxDecoration(
// //                 image: DecorationImage(
// //                   image: NetworkImage("https://via.placeholder.com/420x420"),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             top: 500,
// //             left: 16,
// //             child: Container(
// //               width: MediaQuery.of(context).size.width - 32,
// //               height: 77,
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(15),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Color(0x30000000),
// //                     blurRadius: 4,
// //                     offset: Offset(0, 5),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             top: 590,
// //             left: 16,
// //             child: Container(
// //               width: MediaQuery.of(context).size.width - 32,
// //               height: 77,
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(15),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Color(0x30000000),
// //                     blurRadius: 4,
// //                     offset: Offset(0, 5),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// //
// // // 하단바 메뉴 리스트
// // class MenuList extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.white,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //         children: [
// //           _buildMenuItem(context, Icons.home, 'Home'),
// //           _buildMenuItem(context, Icons.search, 'Search'),
// //           _buildMenuItem(context, Icons.notifications, 'Notifications'),
// //           _buildMenuItem(context, Icons.account_circle, 'Profile'),
// //           _buildMenuItem(context, Icons.settings, 'Settings'),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // 공통 메뉴 항목 생성 위젯
// //   Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
// //     return Expanded(
// //       child: InkWell(
// //         onTap: () {
// //           // Handle menu item tap
// //         },
// //         child: Container(
// //           padding: EdgeInsets.symmetric(vertical: 12.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(icon, color: Colors.black),
// //               SizedBox(height: 4),
// //               Text(
// //                 label,
// //                 style: TextStyle(color: Colors.black, fontSize: 12),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }