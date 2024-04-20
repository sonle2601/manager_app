import 'package:flutter/material.dart';
import '../app_text.dart';

class SelectGender {
  static void showSelectGender(BuildContext context, Function(String gender) onSelect) {
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
                      AppText(text: "Chọn giới tính"),
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
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _buildSalaryTypeItem("Nam", () {
                          onSelect("Nam");
                          Navigator.pop(context); // Đóng bottom sheet sau khi chọn
                        }),
                        _buildSalaryTypeItem("Nữ", () {
                          onSelect("Nữ");
                          Navigator.pop(context); // Đóng bottom sheet sau khi chọn
                        }),
                      ],
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

  static Widget _buildSalaryTypeItem(String text, VoidCallback onTap) {
    return Column(
      children: [
        Divider(height: 13,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppText(text: text),
          ),
        ),
      ],
    );
  }
}
