import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/location_model.dart';
import '../../../view_models/location_view_model.dart';

class SelectDistrict {
  static Future<void> showSelectDistricts(BuildContext context,String  provinceId, Function(String idDistricts,String nameDistricts) onSelect) async {
    final locationVM = Get.put(LocationViewModel());
    final List<District> districts = await locationVM.getDistricts(provinceId);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
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
                      Text("Chọn Huyện / Quận"),
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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: districts.length,
                      itemBuilder: (context, index) {
                        var district = districts[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onSelect(district.id,district.name); // Gọi hàm onSelect và truyền ID của phần tử đã chọn
                                Navigator.pop(context); // Đóng bottom sheet sau khi chọn
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  district.name.toString(),
                                ),
                              ),
                            ),
                            if (index != districts.length - 1) // Đừng hiển thị dấu phân cách dưới cùng
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.black12,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
