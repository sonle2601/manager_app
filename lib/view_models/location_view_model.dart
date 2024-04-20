import '../models/location_model.dart';
import '../repository/location_repository.dart';

class LocationViewModel {
  final _api = LocationRepository();

  Future<List<Province>> getProvinces() async {
    final List<dynamic> jsonData = await _api.getProvinces();
    final List<Province> provinces = jsonData.map((json) => Province.fromJson(json)).toList();
    return provinces;
  }


  Future<List<District>> getDistricts(String provinceId) async {
    final List<dynamic> jsonData = await _api.getDistricts(provinceId);
    final List<District> districts = jsonData.map((json) => District.fromJson(json)).toList();
    return districts;
  }

  Future<List<Ward>> getWards(String districtId) async {
    final List<dynamic> jsonData = await _api.getWards(districtId);
    final List<Ward> wards = jsonData.map((json) => Ward.fromJson(json)).toList();
    return wards;
  }

}