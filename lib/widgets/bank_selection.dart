import 'package:flutter/material.dart';

import 'app_text_field.dart';

class Bank {
  final String name;
  final IconData icon;

  Bank(this.name, this.icon);
}

class BankSelection extends StatefulWidget {
  final TextEditingController accNumberController;
  final void Function(String?)? onBankSelected;
  const BankSelection({Key? key, required this.accNumberController, this.onBankSelected}) : super(key: key);

  @override
  State<BankSelection> createState() => _BankSelectionState();
}

class _BankSelectionState extends State<BankSelection> {
  TextEditingController numberController = TextEditingController();
  Bank? _selectedBank;
  List<Bank> _banks = [
    Bank('Ngân hàng TMCP Ngoại Thương Việt Nam (Vietcombank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Công Thương Việt Nam (VietinBank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Quân Đội (MBBank)', Icons.account_balance),
    Bank('Ngân hàng NN&PT Nông thôn Việt Nam (Agribank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Kỹ Thương (Techcombank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Sài Gòn Thương Tín (Sacombank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Đầu tư và Phát triển Việt Nam (BIDV)', Icons.account_balance),
    Bank('Ngân hàng TMCP Á Châu (ACB)', Icons.account_balance),
    Bank('Ngân hàng TMCP Quốc Dân (NCB)', Icons.account_balance),
    Bank('Ngân hàng TMCP Tiên Phong (TPBank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Đông Á (DongA Bank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Hàng Hải Việt Nam (Maritime Bank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Việt Á (VietABank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Đại Dương (OceanBank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Xuất Nhập Khẩu Việt Nam (Eximbank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Đông Nam Á (SeABank)', Icons.account_balance),
    Bank('Ngân hàng TMCP Đại Chúng Việt Nam (PVcomBank)', Icons.account_balance),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(1, 10),
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            height: 50,
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<Bank>(
                  isDense: true,
                  value: _selectedBank,
                  hint: Row(
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Chọn ngân hàng"),
                    ],
                  ),
                  items: _banks.map((Bank bank) {
                    return DropdownMenuItem<Bank>(
                      value: bank,
                      child: Row(
                        children: [
                          Icon(
                            bank.icon,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 248, // Đặt chiều rộng tối đa cho đoạn văn bản
                            child: Text(
                              bank.name,
                              softWrap: true, // Cho phép văn bản xuống dòng tự động
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Bank? value) {
                    setState(() {
                      _selectedBank = value;
                      widget.onBankSelected!(_selectedBank!.name);
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          AppTextField(textEditingController: widget.accNumberController,
              keyboardType: TextInputType.number,
              hintText: "Nhập số tài khoản",
              icon: Icons.numbers, title: "Số tài khoản",
              message: "Nhập số tài khoản")
        ],
      ),
    );
  }

}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('Bank Selection')),
//       body: Center(child: BankSelection()),
//     ),
//   ));
// }
