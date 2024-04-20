import 'package:flutter/material.dart';

class ImageIcons extends StatelessWidget {
  final double height;
  final double width;
  String? image;
  Color? color;
  ImageIcons({super.key,
    required this.height,
    required this.width,
    this.image = "assets/images/user.jpg",
    this.color = Colors.white,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:  BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image!),
        ),
      ),
    );
  }
}
