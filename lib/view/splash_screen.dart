import 'dart:async';
import 'package:flutter/material.dart';

import '../services/user_preference_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserPreferenceServices userPreferenceServices = UserPreferenceServices();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () {
      userPreferenceServices.isLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hình ảnh hoặc logo (đặt trong thư mục assets của bạn)
            Image.asset(
              'assets/images/user.png', // Đường dẫn tới hình ảnh hoặc logo
              width: 150, // Kích thước của hình ảnh hoặc logo
              height: 150,
            ),
            SizedBox(height: 20), // Khoảng cách giữa hình ảnh và tiêu đề
            Text(
              'Quản lý nhân sự', // Tiêu đề
              style: TextStyle(
                fontSize: 24, // Kích thước chữ
                fontWeight: FontWeight.bold, // Độ đậm
              ),
            ),
            SizedBox(height: 20), // Khoảng cách giữa tiêu đề và tiến trình chờ
            // CircularProgressIndicator(), // Tiến trình chờ
          ],
        ),
      ),
    );
  }
}
