import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/task_view_models/parts_view_model.dart';
import '../app_text.dart';

class SelectParts {
  static void showSelectParts(BuildContext context, Function(int idPart, String namePart) onSelect) {
    final partsVM = Get.put(PartsViewModel());

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 220,
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
                      AppText(text: "Chọn bộ phận"),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Đóng bottom sheet khi nhấn nút hủy
                        },
                        child: Text(
                          'Hủy',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Khoảng cách giữa các phần tử
                  Obx(() =>
                  partsVM.loadData() ?
                  partsVM.parts.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: partsVM.parts.length,
                      itemBuilder: (context, index) {
                        var part = partsVM.parts[index];
                        print(part);
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
                                  onSelect(part.id!, part.partName!); // Gọi hàm onSelect và truyền ID của phần tử đã chọn
                                  Navigator.pop(context); // Đóng bottom sheet sau khi chọn
                                });
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                  text: partsVM.parts[index].partName.toString(),
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
