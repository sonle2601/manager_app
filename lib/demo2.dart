import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberPickerDemo(),
    );
  }
}

class NumberPickerDemo extends StatefulWidget {
  @override
  _NumberPickerDemoState createState() => _NumberPickerDemoState();
}

class _NumberPickerDemoState extends State<NumberPickerDemo> {
  int _currentValue = 0;

  void _showNumberPicker(BuildContext context) {
    showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 350.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      NumberPicker(
                        value: _currentValue,
                        minValue: 0,
                        maxValue: 1000,
                        onChanged: (int? value) {
                          setModalState(() {
                            _currentValue = value ?? 0;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(_currentValue);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((int? value) {
      if (value != null) {
        setState(() => _currentValue = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Number:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_currentValue',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showNumberPicker(context);
              },
              child: Text('Select Number'),
            ),
          ],
        ),
      ),
    );
  }
}
