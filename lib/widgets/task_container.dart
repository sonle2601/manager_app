import 'package:flutter/material.dart';

import 'app_text.dart';
import 'dart:math';
// import 'icon_and_text.dart';

class TaskContainer extends StatelessWidget {
  final List<Widget> components;
  final String title;
  // final double height;

  const TaskContainer({super.key,
    required this.components,
    required this.title,
 });

  @override
  Widget build(BuildContext context) {

    double count = (components.length / 3).ceilToDouble();
    // print('ciel $count');
    double height = (20 + (115 * count)) ;
    // print(height);
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 5, right: 5, top: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft, // Căn chỉnh văn bản về phía trái
            child: Container(
              height: 30  ,
              padding: EdgeInsets.only(left: 11.0, top: 5), // Tạo khoảng cách từ lề trái
              child: AppText(text: title,size: 17, color: Colors.black,),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 15),
            height: .5, // Độ dày của dòng kẻ
            width: double.infinity, // Chiều rộng của dòng kẻ, ở đây đặt là full width
            color: Colors.grey, // Màu của dòng kẻ
          ),
          Wrap(
            spacing: 20, // Khoảng cách giữa các thành phần
            runSpacing: 25, // Khoảng cách giữa các dòng
            // alignment: WrapAlignment.start,
            children: components,
          ),
        ],
      ),
    );
  }
}
