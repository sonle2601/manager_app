import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/utils/format_util.dart';
import 'package:manage_app/view/saraly/salary_bonus/salary_bonus_widget.dart';
import 'package:manage_app/view/saraly/salary_penalty/salary_penalty_widget.dart';
import 'package:manage_app/view/task/news_feed/news_widget.dart';
import 'package:manage_app/view_models/news_view_model.dart';
import 'package:manage_app/view_models/task_view_models/salary_bonus_view_model.dart';
import 'package:manage_app/view_models/task_view_models/salary_penalty_view_model.dart';

import '../../../routes/route_name.dart';
import '../../../widgets/app_text.dart';

class NewsListScreen extends StatelessWidget {
  NewsListScreen({super.key});
  final newsVM = Get.put(NewsViewModel());


  @override
  Widget build(BuildContext context) {
    newsVM.getNews();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.92),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Danh tin tức",
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
          preferredSize: const Size.fromHeight(.20),
          child: Container(
            height: .4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 11, right: 11),
            color: Colors.grey,
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (newsVM.news.isEmpty) {
              return Center(
                child: CircularProgressIndicator(), // Vòng loading
              );
            } else {
              return ListView.builder(
                itemCount: newsVM.news.length,
                itemBuilder: (context, index) {
                  var news = newsVM.news[index];
                  return NewWidget(
                    onTap: (){
                      newsVM.updateNewsScreen(news);
                    },
                    title: news.title,
                    date: news.createdAt,
                  );
                },
              );
            }
          }),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                newsVM.resetTextField();
                Get.toNamed(RouteName.newsAddScreen);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
