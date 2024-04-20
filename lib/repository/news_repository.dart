import 'dart:developer';

import 'package:manage_app/models/news_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class NewsRepository{
  final _apiService = NetworkApiServices();

  Future<List<NewsModel>> getNews() async {

    dynamic response = await _apiService.getApi(AppUrl.news);
    if (response != null && response is List) {
      List<NewsModel> newsModel = List<NewsModel>.from(
        response.map((news) => NewsModel.fromJson(news)).toList(),
      );
      return newsModel;
    }
    else {
      return [];
    }
  }

  Future<dynamic> addNews(var data){
    dynamic response = _apiService.postApi(data, AppUrl.news);
    return response;
  }

  Future<dynamic> updateNews(var data) async{
    dynamic response = await _apiService.putApi(data, AppUrl.news);
    return response;
  }

  Future<void> delete(String id) async {
    dynamic response = await _apiService.deleteApi(AppUrl.newsDelete(id));
    return response;
  }

}