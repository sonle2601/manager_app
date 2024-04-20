import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {

  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;

  const RoundButton({super.key,
     this.loading = false,
    required this.title,
    this.height = 50,
    this.width = 60,
    required this.onPress,
     this.textColor = Colors.blueAccent,
     this.buttonColor = Colors.blueAccent,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50)
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
