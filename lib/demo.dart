import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0, // Giới hạn chiều cao của container
          color: CupertinoColors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop(_selectedTime);
                      },
                      child: Text(
                        'Select',
                        style: TextStyle(
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Khoảng cách giữa số lựa chọn giờ và số lựa chọn phút
              Container(
                height: 200.0, // Giới hạn chiều cao của CupertinoDatePicker
                child: CupertinoDatePicker(
                  // itemExtent : 40,
                  // use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(2022, 1, 1, _selectedTime.hour, _selectedTime.minute),
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      _selectedTime = TimeOfDay.fromDateTime(dateTime);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Time: ${_selectedTime.hour}:${_selectedTime.minute}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
