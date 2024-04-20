import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkDateWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Callback function để trả về ngày được chọn

  const WorkDateWidget({
    super.key,
    required this.onDateSelected}
      );

  @override
  State<WorkDateWidget> createState() => _WorkDateWidgetState();
}

class _WorkDateWidgetState extends State<WorkDateWidget> {
  int _currentWeekIndex = 0;
  int _selectedDayIndex = DateTime.now().weekday - 1; // Ngày được chọn mặc định là ngày hiện tại
  List<String> _weekDays = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'];

  void _previousWeek() {
    setState(() {
      _currentWeekIndex--;
    });
  }

  void _nextWeek() {
    setState(() {
      _currentWeekIndex++;
    });
  }

  DateTime getSelectedDate(DateTime startOfWeek, int selectedDayIndex) {
    return startOfWeek.add(Duration(days: selectedDayIndex));
  }

  void _handleDayTap(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
    DateTime selectedDate = getSelectedDate(
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).add(Duration(days: 7 * _currentWeekIndex)),
        _selectedDayIndex);
    if (widget.onDateSelected != null) {
      widget.onDateSelected(selectedDate); // Gọi hàm callback và trả về ngày được chọn
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)).add(Duration(days: 7 * _currentWeekIndex));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    String formattedStartOfWeek = DateFormat('dd/MM/yyyy').format(startOfWeek);
    String formattedEndOfWeek = DateFormat('dd/MM/yyyy').format(endOfWeek);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 16),
              onPressed: _previousWeek,
            ),
            SizedBox(width: 20),
            Text(
              'Tuần này: $formattedStartOfWeek - $formattedEndOfWeek',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: _nextWeek,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _weekDays.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                _handleDayTap(entry.key);
              },
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: _selectedDayIndex == entry.key ? Colors.blue : Colors.grey, // Màu nền của container
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      entry.value,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat('dd').format(startOfWeek.add(Duration(days: entry.key))),
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
