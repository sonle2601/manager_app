import 'package:flutter/material.dart';

import 'app_text_field.dart';


class BirthdayInput extends StatefulWidget {
  final TextEditingController birthdayController ;

  const BirthdayInput({super.key, required this.birthdayController});

  @override
  _BirthdayInputState createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = '';
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
        child:  GestureDetector(
          onTap: () {
            _showDatePicker(context);
          },
          child: AppTextField(
            enabled: false,
            title: "Birthday",
            icon: Icons.calendar_today,
            textEditingController: _dateController,
            hintText: 'Nhập ngày sinh',
            message: 'Birthday',
          ),
        ),


    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.yellow, // Header color
              onPrimary: Colors.white, // Text color
              surface: Colors.white, // Background color
            ),
            dialogBackgroundColor: Colors.white, // Dialog background color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
        '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
        widget.birthdayController.text = _dateController.text;
      });
    }
  }
}
