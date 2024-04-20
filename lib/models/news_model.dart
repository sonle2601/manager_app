class NewsModel {
  int? id;
  String? title;
  String? content;
  String? image;
  int? storeId;
  String? createdAt;

  NewsModel({this.id,this.title, this.content, this.image, this.storeId, this.createdAt});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    return data;
  }
}