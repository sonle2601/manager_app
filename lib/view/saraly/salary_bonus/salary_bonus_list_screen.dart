import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/utils/format_util.dart';
import 'package:manage_app/view/saraly/salary_bonus/salary_bonus_widget.dart';
import 'package:manage_app/view_models/task_view_models/salary_bonus_view_model.dart';

import '../../../routes/route_name.dart';
import '../../../widgets/app_text.dart';

class SalaryBonusListScreen extends StatelessWidget {
  SalaryBonusListScreen({super.key});
  final SalaryBonusViewModel salaryBonusVM = Get.put(SalaryBonusViewModel());


  @override
  Widget build(BuildContext context) {
    salaryBonusVM.getSalaryBonus();
    log("message");
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.92),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Danh sách thưởng",
          size: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(.20),
          child: Container(
            height: .4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 11, right: 11),
            color: Colors.grey,
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (salaryBonusVM.salaryBonus.isEmpty) {
              return Center(
                child: CircularProgressIndicator(), // Vòng loading
              );
            } else {
              return ListView.builder(
                itemCount: salaryBonusVM.salaryBonus.length,
                itemBuilder: (context, index) {
                  var salaryBonus = salaryBonusVM.salaryBonus[index];

                  return SalaryBonusWidget(
                      onTap: (){
                        salaryBonusVM.salaryBonusDetail(salaryBonus);
                      },
                      employeeName: salaryBonus.employee!.information!.hoTen.toString(),
                      amount: salaryBonus.amount.toString(),
                      reason: salaryBonus.reason.toString(),
                      date: FormatUtils.formatDateString(salaryBonus.createdAt));
                },
              );
            }
          }),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(RouteName.salaryBonusAddScreen);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
