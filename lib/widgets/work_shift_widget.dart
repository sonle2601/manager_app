import 'package:flutter/material.dart';
import 'package:manage_app/widgets/app_text.dart';

class WorkShiftWidget extends StatelessWidget {
  final String title;
  final int status;
  final String startTime;
  final String endTime;
  final VoidCallback onTap;

  const WorkShiftWidget({
    Key? key,
    required this.title,
    required this.status,
    required this.onTap,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 30),
              child: Image.asset(
                'assets/images/work_shift.png',
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: title,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  AppText(
                    text: "Bắt đầu ${startTime}",
                    color: Colors.black38,
                    size: 14,
                  ),
                  SizedBox(height: 10),
                  AppText(
                    text: "Kết thúc ${endTime}",
                    color: Colors.black38,
                    size: 14,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 35),
              child: CircleAvatar(
                radius: 6,
                backgroundColor: status == 1 ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
