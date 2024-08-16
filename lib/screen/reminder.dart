import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../api/disaster_provider.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 페이지가 다시 보일 때마다 데이터 로드 호출
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<DisasterProvider>(context, listen: false);

    // API 호출을 진행 중인 상태인지 확인
    if (!provider.isLoading) {
      await provider.loadDisasterMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  _loadData();
                },
              ),
            ],
          ),
          body: provider.disasterMessages.isEmpty && provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : provider.disasterMessages.isEmpty && !provider.isLoading
              ? Center(child: Text('No disaster messages found'))
              : ListView(
            padding: EdgeInsets.zero,
            children: [
              ...provider.disasterMessages.map((message) {
                final index = provider.disasterMessages.indexOf(message);
                return buildReminderBox(
                  top: MediaQuery.of(context).size.height * 0.12 + (index * MediaQuery.of(context).size.height * 0.11),
                  screenWidth: MediaQuery.of(context).size.width,
                  screenHeight: MediaQuery.of(context).size.height,
                  text: '[${message.rcptnRgnNm}] ${message.msgCn}',
                  registrationDate: message.regYmd,
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

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
