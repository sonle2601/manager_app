import 'package:flutter/material.dart';
import 'package:manage_app/utils/format_util.dart';
import 'package:manage_app/utils/utils.dart';
import 'package:manage_app/widgets/app_text.dart';

class SalaryBonusWidget extends StatelessWidget {
  final String employeeName;
  final String amount;
  final String reason;
  final String date;
  final VoidCallback? onTap;
  const SalaryBonusWidget({
    super.key,
    required this.employeeName,
    required this.amount,
    required this.reason,
    required this.date,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
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
            AppText(text: employeeName, size: 18, fontWeight: FontWeight.bold,),
            SizedBox(height: 5,),
            AppText(text: "Số tiền thưởng ${FormatUtils.formatNumberWithCommas(amount.toString())}"),
            SizedBox(height: 5,),
            AppText(text: "${date}", color: Colors.black54,),
          ],
        ),
      ),
    );
  }
}
