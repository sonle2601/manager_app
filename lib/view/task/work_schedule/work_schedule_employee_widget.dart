import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';

class WorkScheduleEmployeeWidget extends StatelessWidget {
  final String nameEmployee;
  final String partEmployee;
  final String? nameWork;
  final int? status;
  const WorkScheduleEmployeeWidget({
    super.key,
    required this.nameEmployee,
    required this.partEmployee,
     this.nameWork = 'Không có việc chính',
    this.status = 1
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                height: 35,
                child: Image.asset('assets/images/user.png'),
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: '${nameEmployee} ${getStatus(status)}', color: Colors.black87,fontWeight: FontWeight.bold),
                  SizedBox(height: 4,),
                  AppText(text: "${partEmployee} | ${nameWork}", color: Colors.grey,size: 14),
                  SizedBox(height: 10,),
                ],
              ),
              SizedBox(width: 90,),
              // Container(
              //   height: 25,
              //   child: Image.asset('assets/images/add_work.png'),
              // ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            height: .6,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ),

    );
  }
String? getStatus(int? status){
    if(status == 1){
      return '';
    }else{
      return "( Đã xin nghỉ )";
    }
}
}
