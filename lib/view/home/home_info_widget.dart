import 'package:flutter/material.dart';

import '../../widgets/app_text.dart';

class HomeInfoWidget extends StatelessWidget {
  final String image;
  final String title;
  final String number;
   HomeInfoWidget({
     super.key,
     required this.image,
     required this.title,
     required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 40,
              child: Image.asset('assets/images/${image}')
          ),
          SizedBox(height: 5,),
          AppText(text: number, size: 18 , fontWeight: FontWeight.bold,),
          SizedBox(height: 5,),
          AppText(text: title, size: 14,),
        ],
      ),
    );
  }
}
