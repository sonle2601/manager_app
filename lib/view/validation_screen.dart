import 'package:flutter/material.dart';

import '../widgets/round_button.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // Combine entered codes
    String code = _controllers.map((controller) => controller.text).join();
    // Handle form submission, e.g., validate the code
    print('Validating code: $code');
    // Your validation logic goes here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.redAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vui lòng nhập mã",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Nhập mã xác thực gồm 6 chữ số vào các ô sau đó ấn gửi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height ,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              // child: Text("hi"),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        6,
                            (index) => SizedBox(
                          width: 40,
                          child: TextFormField(
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: '',
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a digit';
                              }
                              // You can add additional validation logic here if needed
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.55, // Điều chỉnh vị trí của nút "Gửi"
            left: 20,
            right: 20,
            child: SizedBox( // Sử dụng SizedBox để tạo khoảng cách giữa khối nhập mã và nút "Gửi"
              width: double.infinity,
              child: Container(
                child: RoundButton(title: "Gửi", onPress: _submitForm), // Sử dụng _submitForm để gọi hàm xử lý khi nút được nhấn
              ),
            ),
          ),

        ],
      ),
    );
  }
}
