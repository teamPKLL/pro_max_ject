import 'package:flutter/material.dart';
import 'package:pro_max_ject/api/disaster_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> with AutomaticKeepAliveClientMixin<Reminder> {
  late ScrollController _scrollController;
  bool _isDisposed = false; // dispose 상태를 확인하기 위한 플래그

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        // 스크롤이 끝까지 내려갔을 때
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          _loadMoreData();
        }
      });
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadData();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true; // 위젯이 dispose되었음을 표시
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData({bool refresh = false}) async {
    final provider = Provider.of<DisasterProvider>(context, listen: false);
    if (!provider.isLoading) {
      await provider.loadDisasterMessages(refresh: refresh);
      if (mounted && !_isDisposed) {
        setState(() {}); // 상태 업데이트
      }
    }
  }

  Future<void> _loadMoreData() async {
    final provider = Provider.of<DisasterProvider>(context, listen: false);
    if (!provider.isLoading && provider.hasMore) {
      await Future.delayed(Duration(seconds: 1));
      await provider.loadDisasterMessages();
      if (mounted && !_isDisposed) {
        setState(() {}); // 상태 업데이트
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);  // AutomaticKeepAliveClientMixin의 기능 활성화
    return Consumer<DisasterProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF0F1F0),
          appBar: AppBar(
            title: Text('알림'),
            centerTitle: true,
            backgroundColor: Colors.grey[200],
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _loadData(refresh: true);
                },
              ),
            ],
          ),
          body: provider.isLoading && provider.disasterMessages.isEmpty
              ? Center(child: CircularProgressIndicator())
              : provider.disasterMessages.isEmpty
              ? Center(child: Text('No disaster messages found'))
              : ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: provider.disasterMessages.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.disasterMessages.length) {
                // 마지막 아이템일 때 추가 로딩 인디케이터 표시
                if (provider.hasMore) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox.shrink(); // 더 이상 데이터가 없으면 빈 위젯 반환
                }
              }

              final message = provider.disasterMessages[index];
              return buildReminderBox(
                top: MediaQuery.of(context).size.height * 0.12 + (index * MediaQuery.of(context).size.height * 0.11),
                screenWidth: MediaQuery.of(context).size.width,
                screenHeight: MediaQuery.of(context).size.height,
                text: '[${message.rcptnRgnNm}] ${message.msgCn}',
                registrationDate: message.regYmd,
              );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildReminderBox({
    required double top,
    required double screenWidth,
    required double screenHeight,
    required String text,
    required String registrationDate,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: screenWidth * 0.05),
      height: screenHeight * 0.1,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x30000000),
            blurRadius: 4,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color(0xFF24252C),
                    fontSize: 11,
                    fontFamily: 'Lexend Deca',
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 8,
              child: Text(
                _formatDate(registrationDate),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontFamily: 'Lexend Deca',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final cleanDateStr = dateStr.split('.').first;
      final DateTime date = DateTime.parse(cleanDateStr);
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
      return formatter.format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
