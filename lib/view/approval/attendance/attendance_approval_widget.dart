import 'package:flutter/material.dart';
import 'package:manage_app/widgets/app_text.dart';

class AttendanceApprovalWidget extends StatelessWidget {
  final String employeeName;
  final String nameWorkShift;
  final String date;
  final VoidCallback? onTap;
  const AttendanceApprovalWidget({
    super.key,
    required this.employeeName,
    required this.nameWorkShift,
    required this.date,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: employeeName, size: 18, fontWeight: FontWeight.bold,),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green
                  ),
                  child: AppText(
                    text: "Chưa duyệt",
                    color: Colors.white,
                    size: 15,
                  ),
                )
              ],
            ),
            AppText(text: 'Yêu cầu chấm công bổ sung'),
            SizedBox(height: 5,),
            AppText(text: "${nameWorkShift} ngày ${date}"),
          ],
        ),
      ),
    );
  }
}
