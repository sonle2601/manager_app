class PartsModel {
  int? id;
  int? storeId;
  String? partName;
  String? partDescription;
  int? partStatus;

  PartsModel(
      {this.id,
        this.storeId,
        this.partName,
        this.partDescription,
        this.partStatus,
});

  PartsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    partName = json['part_name'] ?? ''; // Kiểm tra và gán giá trị mặc định nếu giá trị là null
    partDescription = json['part_description'] ; // Kiểm tra và gán giá trị mặc định nếu giá trị là null
    partStatus = json['part_status'] as int?;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(partDescription != null){
      data['part_description'] = this.partDescription;
    }
    if(id != null){
      data['id'] = this.id;

    }
    if(storeId != null){
      data['store_id'] = this.storeId;
    }
    data['part_name'] = this.partName;
    if(partStatus != null){
      data['part_status'] = this.partStatus;

    }
    return data;
  }
}