import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import '../widgets/big_text.dart';
import '../widgets/image_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            // color: Colors.brown,
            height: 280,
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                      height: Dimensions.height220,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/afternoon.png'),
                        ),
                      ),

                    )
                ),
                Positioned(
                  top: Dimensions.height35,
                  left: Dimensions.width20,
                  child: Container(
                      child: BigText(text: "Chào buổi chiều",size: Dimensions.iconSize24,)
                  ),
                ),
                Positioned(
                    top: Dimensions.height80,
                    left: Dimensions.width20,
                    child: Container(
                      child: Row(
                        children: [
                          ImageIcons(height: 50, width: 50, image: "assets/images/user.jpg",),
                          SizedBox(width: Dimensions.width10,),
                          BigText(text: "Sơn Lê", size: Dimensions.iconSize24,)
                        ],
                      ),
                    )

                ),
                Positioned(
                  top: Dimensions.height200,
                  right: Dimensions.height10,
                  left: Dimensions.width10,
                  child: Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radius15),
                      ),
                      color: Colors.greenAccent,
                    ),
                    height: Dimensions.height80,
                    width: Dimensions.screenWidth,
                    child: Row(
                      children: [
                        SizedBox(width: Dimensions.width30,),
                        ImageIcons(
                          height: Dimensions.height55,
                          width: Dimensions.width55,
                          image: "assets/images/stopwatch.png",
                        ),
                        SizedBox(width: Dimensions.width20,),
                        BigText(text: "Yêu Cầu",size: Dimensions.font24,color: Colors.black38, ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
