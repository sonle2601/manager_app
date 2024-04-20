import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class SelectTime {

  static void selectTime(BuildContext context, Function(int hour, int minute) onSelect) {
    int hour = 0;
    int minute = 0;

    showModalBottomSheet<List<int>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close bottom sheet on cancel
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          onSelect(hour, minute); // Pass selected time back to the caller
                          Navigator.pop(context); // Close bottom sheet on select
                        },
                        child: Text(
                          'Select',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Spacing between elements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        onChanged: (value) {
                          setModalState(() {
                            hour = value;
                          });
                        },
                        textStyle: TextStyle(color: Colors.black54, fontSize: 20),
                        selectedTextStyle: TextStyle(color: Colors.black, fontSize: 30),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black54),
                            bottom: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: minute,
                        onChanged: (value) {
                          setModalState(() {
                            minute = value;
                          });
                        },
                        textStyle: TextStyle(color: Colors.black54, fontSize: 20),
                        selectedTextStyle: TextStyle(color: Colors.black, fontSize: 30),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black54),
                            bottom: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
