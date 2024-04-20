import 'package:flutter/material.dart';
import '../app_text.dart';

class Bank {
  final String name;
  final IconData? icon;

  Bank(this.name, {this.icon = Icons.account_balance });
}

class SelectBank {
  static void showSelectBank(BuildContext context, Function(String bankName) onSelect) {
    List<Bank> _banks = [
      Bank('Ngân hàng TMCP Ngoại Thương Việt Nam (Vietcombank)',icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Công Thương Việt Nam (VietinBank)',icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Quân Đội (MBBank)', icon: Icons.account_balance),
      Bank('Ngân hàng NN&PT Nông thôn Việt Nam (Agribank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Kỹ Thương (Techcombank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Sài Gòn Thương Tín (Sacombank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Đầu tư và Phát triển Việt Nam (BIDV)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Á Châu (ACB)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Quốc Dân (NCB)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Tiên Phong (TPBank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Đông Á (DongA Bank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Hàng Hải Việt Nam (Maritime Bank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Việt Á (VietABank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Đại Dương (OceanBank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Xuất Nhập Khẩu Việt Nam (Eximbank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Đông Nam Á (SeABank)', icon: Icons.account_balance),
      Bank('Ngân hàng TMCP Đại Chúng Việt Nam (PVcomBank)', icon: Icons.account_balance),
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 350,
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
                      AppText(text: "Chọn ngân hàng"),
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
                      itemCount: _banks.length,
                      itemBuilder: (context, index) {
                        return _buildBankItem(_banks[index], () {
                          onSelect(_banks[index].name);
                          Navigator.pop(context); // Đóng bottom sheet sau khi chọn
                        });
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

  static Widget _buildBankItem(Bank bank, VoidCallback onTap) {
    return Column(
      children: [
        Divider(height: 13,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(bank.icon, color: Colors.yellow,),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    bank.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14), // Giảm kích thước font
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
