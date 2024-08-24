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

  @override
  void initState() {
    super.initState();
    _loadData(refresh: true);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          _loadMoreData();
        }
      });
  }

  @override
  void dispose() {
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
    super.build(context);
    return Consumer<DisasterProvider>(
      builder: (context, provider, child) {
        final filteredMessages = provider.disasterMessages;

        return Scaffold(
          backgroundColor: Color(0xFFF0F1F0),
          appBar: AppBar(
            title: Text('알림'),
            centerTitle: true,
            backgroundColor: Colors.grey[200],
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _showFilterDialog,
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => _loadData(refresh: true),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _localFilters.keys.length,
                itemBuilder: (context, index) {
                  final type = _localFilters.keys.elementAt(index);
                  return Container(
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(type),
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('취소'),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(_localFilters);
            Navigator.of(context).pop();
          },
          child: Text('완료'),
        ),
      ],
    );
  }
}
