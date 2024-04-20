import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final String image;
  const IconTextButton({super.key, required this.image, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            image,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20,),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
