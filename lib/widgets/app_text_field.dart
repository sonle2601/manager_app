import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController  textEditingController;
  final String hintText;
  final IconData icon;
   String title;
   String message;
  bool? enabled;
  TextInputType keyboardType;
   bool obscureText;
   String? initialValue;

   AppTextField({super.key,
     this.keyboardType = TextInputType.text,
     required this.textEditingController,
     required this.hintText, required this.icon,
      this.title = "",  this.message="",
     this.enabled=true,
     this.obscureText = false,
   });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: Offset(1,10),
              color: Colors.grey.withOpacity(0.2),
            )
          ]
      ),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: obscureText,
        enabled: enabled,
        keyboardType: keyboardType,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 25.0,right: 20),
            child: Icon(icon, color: Colors.yellow,),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
