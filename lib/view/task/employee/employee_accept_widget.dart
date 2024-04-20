import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/app_text.dart';

class EmployeeAcceptWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String status;
  final String email;
  final VoidCallback onTap;


  const EmployeeAcceptWidget({
    Key? key,
    required this.name,
    required this.phone,
    required this.status,
    required this.email,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                'assets/images/user.png',
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
                  AppText(
                    text: getStatusText(status),
                    color: getStatusColor(status),
                    size: 15,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchPhoneCall(phone);
              },
              child: Container(
                margin: EdgeInsets.only(right: 30),
                child: Icon(Icons.phone, color: Colors.blueAccent,),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case '1':
        return 'Đang làm việc';
      case '0':
        return 'Đã nghỉ việc';
      default:
        return 'Không xác định';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case '0':
        return Colors.orange;
      case '1':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

Future<void> _launchPhoneCall(String phoneNumber) async {
  final String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
