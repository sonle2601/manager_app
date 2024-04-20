import 'package:flutter/material.dart';

import '../../widgets/app_text.dart';

class SaralyEmployeeWidget extends StatelessWidget {
  final String nameEmployee;
  final String partEmployee;
  final double saraly;
  final bool? status;
  final VoidCallback? onTap;
  const SaralyEmployeeWidget({
    super.key,
    required this.nameEmployee,
    required this.partEmployee,
    required this.saraly,
    this.status = false,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(15),
                height: 70,
                child: Image.asset('assets/images/user.png')
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: nameEmployee, fontWeight: FontWeight.bold, color: Colors.black87, size: 18),
                  SizedBox(height: 8),
                  AppText(text: partEmployee, size: 14, color: Colors.grey),
                  SizedBox(height: 8),
                  AppText(text: 'Cần thanh toán : ${saraly}', size: 14, color: Colors.grey),
                  SizedBox(height: 8),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: AppText(text: getStatus(status!), size: 14, color: Colors.green)
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(25),
                child: Icon(Icons.arrow_forward_ios, size: 16)
            ),
          ],
        ),
      ),
    );
  }
}

String getStatus(bool status) {
  if(status){
    return "Đã thanh toán";
  }else{
    return "Chưa thanh toán";
  }
}
