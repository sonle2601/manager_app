import 'package:flutter/material.dart';


class ButtonButtom extends StatelessWidget {

  final bool loading;
  final String title;
  final double height;
  final double width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;

  const ButtonButtom({super.key,
    this.loading = false,
    required this.title,
    this.height = 50,
    required this.onPress,
    this.textColor = Colors.blueAccent,
    this.buttonColor = Colors.blueAccent,
    this.width = 200,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: loading ?
        Center(child: CircularProgressIndicator(color: Colors.white38,),):
        Center(child: Text(title,  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        ),
      ),
    );
  }
}
