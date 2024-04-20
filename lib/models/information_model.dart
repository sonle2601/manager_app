class InformationModel {
  int? id;
  String? email;
  String? hoTen;
  String? soCmnd;
  String? soDienThoai;
  String? diaChi;
  String? gioiTinh;
  String? namSinh;
  String? anhMatTruoc;
  String? anhMatSau;
  String? nganHang;
  String? soTaiKhoan;

  InformationModel(
      {this.id,
        this.email,
        this.hoTen,
        this.soCmnd,
        this.soDienThoai,
        this.diaChi,
        this.gioiTinh,
        this.namSinh,
        this.anhMatTruoc,
        this.anhMatSau,
        this.nganHang,
        this.soTaiKhoan,
});

  InformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    hoTen = json['ho_ten'];
    soCmnd = json['so_cmnd'];
    soDienThoai = json['so_dien_thoai'];
    diaChi = json['dia_chi'];
    gioiTinh = json['gioi_tinh'];
    namSinh = json['nam_sinh'];
    anhMatTruoc = json['anh_mat_truoc'];
    anhMatSau = json['anh_mat_sau'];
    nganHang = json['ngan_hang'];
    soTaiKhoan = json['so_tai_khoan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) {
      data['id'] = this.id;
    }
    if (nganHang != null) {
      data['ngan_hang'] = this.nganHang;
    }
    if (soTaiKhoan != null) {
      data['so_tai_khoan'] = this.soTaiKhoan;
    }
    data['email'] = this.email;
    data['ho_ten'] = this.hoTen;
    data['so_cmnd'] = this.soCmnd;
    data['so_dien_thoai'] = this.soDienThoai;
    data['dia_chi'] = this.diaChi;
    data['gioi_tinh'] = this.gioiTinh;
    data['nam_sinh'] = this.namSinh;
    data['anh_mat_truoc'] = this.anhMatTruoc;
    data['anh_mat_sau'] = this.anhMatSau;
    return data;
  }
}