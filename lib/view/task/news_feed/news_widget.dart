import 'package:flutter/material.dart';
import 'package:manage_app/utils/format_util.dart';

import '../../../widgets/app_text.dart';

class NewWidget extends StatelessWidget {
  final String? title;
  final String? date;
  final VoidCallback? onTap;

  const NewWidget({super.key, this.title, this.date, this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              child: Image.asset('assets/images/newspaper.png'),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: title.toString(), fontWeight: FontWeight.bold, size: 18,),
                SizedBox(height: 10,),
                AppText(text: FormatUtils.timeAgo(date.toString()), color: Colors.black38, size: 16,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
