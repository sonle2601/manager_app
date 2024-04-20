import 'package:flutter/material.dart';
import 'package:manage_app/widgets/app_text.dart';

class IconAndText extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback? onTap;
  final int? maxLine;

  const IconAndText({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
    this.maxLine = 2
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
            // height: 100,
            width: MediaQuery.of(context).size.width/3.5,
            child: Column(
              children: [
                Image.asset(
                    'assets/images/$image',
                  height: 40,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                    child: AppText(
                      maxLines: maxLine,
                      text: text,
                      textAlign: TextAlign.center,
                      size: 15,
                      color: Colors.black54,)
                ),
              ],
            ),
      ),
    );
  }
}
