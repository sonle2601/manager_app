import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/employee_view_model.dart';

import '../../view_models/task_view_models/parts_view_model.dart';
import '../app_text.dart';

class SelectEmployee {
  static void showSelectEmployee(BuildContext context, Function(List<int> selectedEmployeeIds) onSelect) {
    final employeeVM = Get.put(EmployeeViewModel());

    List<int> selectedIds = []; // Danh sách các ID của nhân viên được chọn

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
                          onSelect(selectedIds); // Truyền danh sách nhân viên được chọn khi nhấn nút chọn
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
                  employeeVM.loadData() ?
                  employeeVM.employeeAccept.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeVM.employeeAccept.length,
                      itemBuilder: (context, index) {
                        var employees = employeeVM.employeeAccept[index];
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
                                  if (selectedIds.contains(employeeId)) {
                                    selectedIds.remove(employeeId); // Nếu đã chọn, hủy chọn
                                  } else {
                                    selectedIds.add(employeeId); // Nếu chưa chọn, thêm vào danh sách
                                  }
                                });
                              },
                              child: Container(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: selectedIds.contains(employees.id),
                                        onChanged: (value) {
                                          setModalState(() {
                                            int employeeId = employees.id!;
                                            if (value!) {
                                              selectedIds.add(employeeId);
                                            } else {
                                              selectedIds.remove(employeeId);
                                            }
                                          });
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      AppText(
                                        text: employeeVM.employeeAccept[index].information!.hoTen.toString(),
                                      ),
                                      SizedBox(width: 5,),
                                      AppText(
                                        text: '(${employeeVM.employeeAccept[index].information!.email.toString()})',
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                      : Container(
                    height: 50,
                    // alignment: Alignment.topLeft,
                    child: AppText(
                      text: "Chưa có bộ phận nào được thêm",
                    ),
                  )
                      : Container(
                    height: 50,
                    // alignment: Alignment.topLeft,
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
