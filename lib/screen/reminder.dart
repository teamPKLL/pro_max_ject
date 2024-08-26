import 'package:flutter/material.dart';
import 'package:pro_max_ject/api/disaster_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pro_max_ject/models/disaster_message.dart';
import 'package:pro_max_ject/services/disaster_service.dart';
import 'package:pro_max_ject/services/location_service.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> with AutomaticKeepAliveClientMixin<Reminder> {
  late ScrollController _scrollController;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadData(refresh: true);
    _scrollController = ScrollController()
      ..addListener(() {
        // 스크롤이 끝까지 내려갔을 때
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          _loadMoreData();
        }
      });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData({bool refresh = false}) async {
    final provider = Provider.of<DisasterProvider>(context, listen: false);
    await provider.loadDisasterMessages(refresh: refresh);
  }

  Future<void> _loadMoreData() async {
    final provider = Provider.of<DisasterProvider>(context, listen: false);
    await provider.loadDisasterMessages();
  }

  void _showFilterDialog() {
    final provider = Provider.of<DisasterProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialog(
          initialFilters: provider.filters,
          onApply: (updatedFilters) {
            provider.filters = updatedFilters;
            _loadData(refresh: true);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    super.build(context);
    return Consumer<DisasterProvider>(
      builder: (context, provider, child) {
        final filteredMessages = provider.disasterMessages;

        return Scaffold(
          backgroundColor: Color(0xFFF0F1F0),
          appBar: AppBar(
            title:  Text('알림',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'BM_HANNA_TTF',
              )
            ),
            centerTitle: true,
            backgroundColor: const Color(0xEF537052),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white,),
                onPressed: _showFilterDialog,
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white,),
                onPressed: () {
                  _loadData(refresh: true); // 새로고침 시 데이터 로드
                },
              ),
            ],
          ),
          body: provider.isLoading && filteredMessages.isEmpty
              ? Center(child: CircularProgressIndicator())
              : filteredMessages.isEmpty
              ? Center(child: Text('No disaster messages found'))
              : ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: filteredMessages.length + 1,
            itemBuilder: (context, index) {

              if (index == filteredMessages.length) {

                if (provider.hasMore) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox.shrink();
                }
              }

              final message = filteredMessages[index];
              return buildReminderBox(
                top: MediaQuery.of(context).size.height * 0.12 +
                    (index * MediaQuery.of(context).size.height * 0.11),
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
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 15, 30, 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white, // 배경색
        boxShadow: [
          BoxShadow(
            color: Color(0x30000000),
            blurRadius: 4,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Text(text,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Lexend Deca',
              )
            ),
          ),
          const SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Text(_formatDate(registrationDate).toString().substring(0,19),
                style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 13,
                  fontFamily: 'Lexend Deca',
                  fontWeight: FontWeight.w400,
                ),
              )
            ]
          ),
        ],
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

class FilterDialog extends StatefulWidget {
  final Map<String, bool> initialFilters;
  final ValueChanged<Map<String, bool>> onApply;

  FilterDialog({required this.initialFilters, required this.onApply});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late Map<String, bool> _localFilters;

  @override
  void initState() {
    super.initState();
    _localFilters = Map.from(widget.initialFilters);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('재해 구분 필터'),
      content: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,  // 각 아이템의 최대 크기
                  mainAxisSpacing: 5,       // 세로 방향 간격
                  crossAxisSpacing: 5,      // 가로 방향 간격
                  childAspectRatio: 3 / 1,   // 가로와 세로 비율
                ),
                itemCount: _localFilters.keys.length,
                itemBuilder: (context, index) {
                  final type = _localFilters.keys.elementAt(index);
                  return Container(
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      activeColor: Color(0xEF537052),
                      title: Text(type,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      value: _localFilters[type],
                      onChanged: (bool? value) {
                        setState(() {
                          _localFilters[type] = value ?? true;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              overlayColor: Colors.black.withOpacity(0.1),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소',
            style: TextStyle(
              color: Colors.black38,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            overlayColor: Colors.black.withOpacity(0.1),
          ),
          onPressed: () {
            widget.onApply(_localFilters);
            Navigator.of(context).pop();
          },
          child: const Text('완료',
            style: TextStyle(
              color: Color(0xEF537052),
            ),
          ),
        ),
      ],
    );
  }
}

