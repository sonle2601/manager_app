import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  //683, 411

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

  }
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.04;
  static double pageViewTextContainer = screenHeight / 7.03;

//683,
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height220 = screenHeight / 3.1;
  static double height30 = screenHeight / 28.13;
  static double height35 = screenHeight / 19.5;
  static double height300 = screenHeight / 2.27;
  static double height200 = screenHeight / 3.415;
  static double height15 = screenHeight / 56.27;
  static double height45 = screenHeight / 18.76;
  static double height55 = screenHeight / 12.41;
  static double height90 = screenHeight / 7.58;
  static double height80 = screenHeight / 8.53;


//683, 411
  static double width10 = screenHeight / 68.3;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 34.15;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 18.76;
  static double width55 = screenHeight / 12.41;




//683,
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.4;
  static double font16 = screenHeight / 52.75;
  static double font24 = screenHeight / 28.45;




  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  static double iconSize16 = screenHeight/52.75;
  static double iconSize24 = screenHeight / 28.45;
  static double iconSize20 = screenHeight/42.2;
  static double iconSize30 = screenHeight / 28.13;



  //list view size
  static double listViewImgSize = screenWidth/3.25;
  static double listViewTextConstSize = screenWidth/3.9;

//detail food
  static double popularFoodImage = screenHeight/2.41 ;

// bottom height
  static double bottomHeightBar = screenHeight/7.03;



}
