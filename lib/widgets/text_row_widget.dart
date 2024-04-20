import 'package:flutter/material.dart';

import 'app_text.dart';

class TextRowWidget extends StatelessWidget {
  final String title;
  final String info;
  final int? maxLine;
  const TextRowWidget({
    super.key,
    required this.title,
    required this.info,
     this.maxLine = 1
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: AppText(
            maxLines: maxLine,
            color: Colors.grey,
            text: title,
            size: 13,
          ),
          width: 90,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: AppText(
            maxLines: maxLine,
            color: Colors.black87,
            size: 15,
            text: info,
          ),
          width: 235,
        ),
      ],
    );
  }
}
