import 'package:flutter/material.dart';

import '../../widgets/app_text.dart';

class RowTextWidget extends StatelessWidget {
  final String title;
  final String info;
  const RowTextWidget({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        children: [
          Container(
            height: .6,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: title),
              AppText(text: info),
            ],
          ),
        ],
      ),
    );
  }
}
