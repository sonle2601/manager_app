import 'package:flutter/material.dart';

import '../app_text.dart';

class EmployeeWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String? image;
  final List<String>? statusText;

  const EmployeeWidget({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
    this.image = 'assets/images/invitation.png',
    this.statusText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 30),
            child: Image.asset(
              image!,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                AppText(
                  text: name,
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
                SizedBox(height: 15),
                AppText(
                  text: phone,
                  color: Colors.black54,
                  size: 15,
                ),
                SizedBox(height: 10),
                AppText(
                  text: email,
                  color: Colors.black54,
                  size: 15,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case 'waiting':
        return statusText?[1] ?? 'Đang chờ';
      case 'accept':
        return statusText?[2] ?? 'Đã chấp nhận';
      case 'refuse':
        return statusText?[3] ?? 'Đã từ chối';
      default:
        return 'Không xác định';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return Colors.orange;
      case 'accept':
        return Colors.green;
      case 'refuse':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
