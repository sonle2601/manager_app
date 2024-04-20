class StoreModel {
  int? managerId;
  String? ten;
  String? soDienThoai;
  String? thanhPho;
  String? huyen;
  String? xa;
  String? chiTiet;

  StoreModel(
      {this.managerId,
        this.ten,
        this.soDienThoai,
        this.thanhPho,
        this.huyen,
        this.xa,
        this.chiTiet});

  StoreModel.fromJson(Map<String, dynamic> json) {
    managerId = json['manager_id'];
    ten = json['ten'];
    soDienThoai = json['so_dien_thoai'];
    thanhPho = json['thanh_pho'];
    huyen = json['huyen'];
    xa = json['xa'];
    chiTiet = json['chi_tiet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(managerId != null){
      data['manager_id'] = this.managerId;
    }
    data['ten'] = this.ten;
    data['so_dien_thoai'] = this.soDienThoai;
    data['thanh_pho'] = this.thanhPho;
    data['huyen'] = this.huyen;
    data['xa'] = this.xa;
    data['chi_tiet'] = this.chiTiet;
    return data;
  }
}