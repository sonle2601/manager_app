import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/task_view_models/employee_view_model.dart';
import '../app_text.dart';

class SelectEmployeeAvailable {
  static void showSelectEmployee(BuildContext context, Function(int? selectedEmployeeId, String? nameEmployee) onSelect) {
    final employeeVM = Get.put(EmployeeViewModel());

    employeeVM.getEmployeeAvailable();

    int? selectedId; // ID của nhân viên được chọn
    String? selectedName; // Tên của nhân viên được chọn

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 22, left: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Đóng bottom sheet khi nhấn nút hủy
                        },
                        child: Text(
                          'Hủy',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          onSelect(selectedId, selectedName); // Truyền ID và tên của nhân viên được chọn khi nhấn nút chọn
                          Navigator.pop(context); // Đóng bottom sheet khi nhấn nút chọn
                        },
                        child: Text(
                          'Chọn nhân viên',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Khoảng cách giữa các phần tử
                  Obx(() =>
                  employeeVM.loadData.value ?
                  employeeVM.employeeAvailable.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeVM.employeeAvailable.length,
                      itemBuilder: (context, index) {
                        var employees = employeeVM.employeeAvailable[index];
                        print(employeeVM.employeeAvailable[index].information!.hoTen.toString());
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black12,
                            ),
                            GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  int employeeId = employees.id!;
                                  if (selectedId == employeeId) {
                                    selectedId = null; // Nếu đã chọn, hủy chọn
                                    selectedName = null;
                                  } else {
                                    selectedId = employeeId; // Nếu chưa chọn, thêm vào danh sách
                                    selectedName = employeeVM.employeeAvailable[index].information!.hoTen.toString();
                                  }
                                });
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: selectedId == employees.id,
                                      onChanged: (value) {
                                        setModalState(() {
                                          if (value!) {
                                            selectedId = employees.id;
                                            selectedName = employeeVM.employeeAvailable[index].information!.hoTen.toString();
                                          } else {
                                            selectedId = null;
                                            selectedName = null;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    AppText(
                                      text: employeeVM.employeeAvailable[index].information!.hoTen.toString(),
                                    ),
                                    SizedBox(width: 5,),
                                    AppText(
                                      text: '(${employeeVM.employeeAvailable[index].information!.email.toString()})',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                      : Container(
                    height: 50,
                    child: AppText(
                      text: "Chưa có bộ phận nào được thêm",
                    ),
                  )
                      : Container(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
