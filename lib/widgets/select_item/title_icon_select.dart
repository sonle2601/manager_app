import 'package:flutter/material.dart';

import '../app_text.dart';

class TitleIconSelect extends StatelessWidget {
  final String name;
  final String title;
  final IconData icon;
  const TitleIconSelect({super.key, required this.title, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 22, right: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: title, color: Colors.black26, size: 12),
                  SizedBox(height: 5,),
                  AppText(text: name, color: Colors.black87),
                ],
              ),
            ),
          ),
          Icon(icon, color: Colors.black54),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
