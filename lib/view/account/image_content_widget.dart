import 'package:flutter/material.dart';

import '../../widgets/app_text.dart';

class ImageContentWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback? onTap;
  const ImageContentWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  height: 50,
                  child: Image.asset(image)
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: title, fontWeight: FontWeight.bold, color: Colors.black87, size: 18),
                    SizedBox(height: 5),
                    AppText(text: description, size: 14, color: Colors.grey)
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20, ),
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
