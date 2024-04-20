import 'package:flutter/material.dart';
import 'package:manage_app/widgets/app_text.dart';

class LateEarlyApprovalWidget extends StatelessWidget {
  final String employeeName;
  final String nameWorkShift;
  final String reason;
  final String date;
  final String type;
  final VoidCallback? onTap;
  const LateEarlyApprovalWidget({
    super.key,
    required this.employeeName,
    required this.nameWorkShift,
    required this.reason,
    required this.date,
    this.onTap,
    required this.type});

  @override
  Widget build(BuildContext context) {
    String? typeString(String? type){
      if(type == 'late'){
        return '( Xin đi muộn )';
      }else{
        return '( Xin về sớm )';
      }
    }
    String? reasonString(String? reason){
      if(reason == null ){
        return 'Không có';
      }
    }
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
                AppText(text: '${employeeName} ${typeString(type)}', size: 18, fontWeight: FontWeight.bold,),
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
            SizedBox(height: 5,),
            AppText(text: "${nameWorkShift} ngày ${date}"),
            SizedBox(height: 5,),
            AppText(text: 'Lý do : ${reason} ' ),
          ],
        ),
      ),
    );
  }
}
