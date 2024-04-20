class Province {
  final String name;
  // final String fullName;
  final String id;

  Province({
    required this.name,
    // required this.fullName,
    required this.id,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      name: json['province_name'],
      // fullName: json['full_name'],
      id: json['province_id'],
    );
  }
}

class District {
  final String name;
  // final String fullName;
  final String id;

  District({
    required this.name,
    // required this.fullName,
    required this.id,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['district_name'],
      // fullName: json['full_name'],
      id: json['district_id'],
    );
  }
}

class Ward {
  final String name;
  // final String fullName;
  final String id;

  Ward({
    required this.name,
    // required this.fullName,
    required this.id,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      name: json['ward_name'],
      // fullName: json['full_name'],
      id: json['ward_id'],
    );
  }
}
