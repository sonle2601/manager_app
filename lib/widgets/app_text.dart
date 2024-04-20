import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final int? maxLines;
  const AppText( {super.key,
    required this.text,
    this.color=Colors.black,
    this.size=16,
    this.textAlign= TextAlign.left,
    this.fontWeight= FontWeight.normal,
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        // fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: fontWeight
      ),
      textAlign: textAlign,
    );
  }
}
