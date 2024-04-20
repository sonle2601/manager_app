import 'package:flutter/material.dart';

import 'app_text.dart';

class AppBarWidget extends StatelessWidget {
  final String text;
  const AppBarWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.white,
      elevation: 0,
      title:  AppText(
        text: text,
        size: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      bottom: PreferredSize(
        preferredSize:  Size.fromHeight(.20),
        child: Container(
          height: .4,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 11, right: 11),
          color: Colors.grey,
        ),
      ),
    );
  }
}
