import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/news_model.dart';
import 'package:manage_app/repository/news_repository.dart';
import 'package:manage_app/routes/route_name.dart';

import '../utils/utils.dart';
import '../utils/validation.dart';

class NewsViewModel extends GetxController{
  final _api = NewsRepository();

  var news = <NewsModel>[].obs;
  RxBool loadData = false.obs;
  RxBool loading = false.obs;

  // String? employeeId;

  final titleController = TextEditingController().obs;
  final contentController = TextEditingController().obs;
  String? image;
  int? id;

  Future<void> getNews() async {
    try {
      loadData.value = false;
      List<NewsModel> newsModel = await _api.getNews();
      news.assignAll(newsModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  String? validate() {
      if (!isNotEmpty(titleController.value.text)) {
      return "Vui lòng nhập tiêu đề";
    }else  if (!isNotEmpty(contentController.value.text)) {
      return "Vui lòng nhập nội dung";
    }
    return null;
  }


  void updateNewsScreen(NewsModel? newsModel){
    id = newsModel!.id;
    titleController.value.text = newsModel.title.toString();
    contentController.value.text = newsModel.content.toString();
    image = newsModel.image;
    Get.toNamed(RouteName.newsUpdateScreen);
  }

  void updateNews() {
    loading.value = true;
    NewsModel newsModel = NewsModel(
        title: titleController.value.text,
        content: contentController.value.text,
        image: image,
        id: id,
    );

    Map<String, dynamic> data = newsModel.toJson();


    _api.updateNews(data).then((value) {
      loading.value = false;
      Utils.snackBar("Tin tức", "Đã cập nhật tin tức thành công!");
      getNews();
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar("Lỗi", error.toString());
    });
  }

  void resetTextField(){
    titleController.value.text = '';
    contentController.value.text = '';
  }

  void deleteNews(){
    loading.value = true;

    _api.delete(id.toString()).then((value) {
      loading.value = false;
      Utils.snackBar("Tin tức", "Đã xóa tin tức thành công!");
      getNews();
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar("Lỗi", error.toString());
    });
  }

  void addNews() {
    loading.value = true;
    NewsModel newsModel = NewsModel(
      title: titleController.value.text,
      content: contentController.value.text,
      image: image
    );

    Map<String, dynamic> data = newsModel.toJson();


    _api.addNews(data).then((value) {
      loading.value = false;
      Utils.snackBar("Tin tức", "Đã thêm tin tức thành công!");
      getNews();
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar("Lỗi", error.toString());
    });
  }
}