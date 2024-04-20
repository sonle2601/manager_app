import 'package:flutter/material.dart';

enum Gender { male, female }

class GenderSelection extends StatefulWidget {
  final void Function(String?)? onGenderSelected;

  const GenderSelection({Key? key, this.onGenderSelected}) : super(key: key);

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow:  [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      height: 50,
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<Gender>(
            isDense: true,
            value: _selectedGender,
            hint: Row(
              children: [
                Icon(Icons.person_2, color: Colors.yellow,),
                SizedBox(width: 15,),
                Text("Chọn giới tính"),
              ],
            ),
            items: [
              DropdownMenuItem<Gender>(
                value: Gender.male,
                child: Row(
                  children: [
                    Icon(Icons.person_2, color: Colors.yellow,),
                    SizedBox(width: 15,),
                    Text("Nam"),
                  ],
                ),
              ),
              DropdownMenuItem<Gender>(
                value: Gender.female,
                child: Row(
                  children: [
                    Icon(Icons.person_2, color: Colors.yellow,),
                    SizedBox(width: 15,),
                    Text("Nữ"),
                  ],
                ),
              ),
            ],
            onChanged: (Gender? value) {
              setState(() {
                _selectedGender = value;
                if (widget.onGenderSelected != null) {
                  widget.onGenderSelected!(value!.name.toString());
                }
              });
              // Gọi callback để truyền giá trị giới tính đã chọn về bên ngoài

            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
      ),
    );
  }
}
