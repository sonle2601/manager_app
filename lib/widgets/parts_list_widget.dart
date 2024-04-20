import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/parts_model.dart';
import 'package:manage_app/widgets/app_text.dart';

class PartsListWidget extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onTap;

  const PartsListWidget({
    Key? key,
    required this.title,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
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
                'assets/images/parts_list.png',
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: title,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  AppText(
                    text: status,
                    size: 14,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
