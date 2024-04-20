class TokenModels {
  String? token;
  bool? isLogin;
  DateTime? expiration; // Thêm trường thời hạn của token

  TokenModels({this.token, this.isLogin, this.expiration}); // Cập nhật constructor

  TokenModels.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isLogin = json['isLogin'];
    expiration = json['expiration'] != null ? DateTime.parse(json['expiration']) : null; // Parse thời hạn từ String thành DateTime
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['isLogin'] = this.isLogin;
    data['expiration'] = this.expiration?.toIso8601String(); // Chuyển đổi DateTime thành String
    return data;
  }
}
