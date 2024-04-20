import 'package:flutter/material.dart';

import '../models/location_model.dart';
import '../view_models/location_view_model.dart';
import 'app_text_field.dart';

class LocationWidget extends StatefulWidget {
  String? initProvince ;
  String? initDistrict;
  String? initWard;
  final TextEditingController aptNumberController ;
  final void Function(String?, String?, String?)? onLocationSelected;

   LocationWidget({
    Key? key,
    required this.aptNumberController,
    this.onLocationSelected,
    this.initProvince,
    this.initDistrict,
    this.initWard,
  }) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {

  LocationViewModel lVM = LocationViewModel();
  late Future<List<Province>> _provinces;
  late Future<List<District>> _districts;
  late Future<List<Ward>> _wards;


  Province? _selectedProvince ;
  District? _selectedDistrict;
  Ward? _selectedWard;




  @override
  void initState() {
    super.initState();
    _provinces = lVM.getProvinces();
    _districts = Future.value([]);
    _wards = Future.value([]);
  }

  void _onProvinceChanged(Province? province) {
    setState(() {
      _selectedProvince = province;
      _selectedDistrict = null;
      _selectedWard = null;
      if (province != null) {
        _districts = lVM.getDistricts(province.id);
      }
    });
  }

  void _onDistrictChanged(District? district) {
    setState(() {
      _selectedDistrict = district;
      _selectedWard = null;
      if (district != null) {
        _wards = lVM.getWards(district.id);
      }
    });
  }

  void _onWardChanged(Ward? ward) {
    setState(() {
      _selectedWard = ward;
      if (widget.onLocationSelected != null) {
        widget.onLocationSelected!(
          _selectedProvince?.name,
          _selectedDistrict?.name,
          _selectedWard?.name,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320, // hoặc bất kỳ giá trị nào phù hợp
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow:  [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 10),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ),
                child: FutureBuilder<List<Province>>(
                  future: _provinces,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField<Province>(
                            isExpanded: true,
                            value: _selectedProvince,
                            hint: const Text("Chọn Thành Phố"),
                            items: snapshot.data!.map((province) {
                              return DropdownMenuItem<Province>(
                                value: province,
                                child: Text(province.name),
                              );
                            }).toList(),
                            onChanged: _onProvinceChanged,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow:  [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 10),
                      color: Colors.grey.withOpacity(0.2),
                    )
                  ],
                ),
                child: FutureBuilder<List<District>>(
                  future: _districts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField<District>(
                            isDense: true,
                            value: _selectedDistrict,
                            hint: const Text("Chọn Quận/Huyện"),
                            items: snapshot.data!.map((district) {
                              return DropdownMenuItem<District>(
                                value: district,
                                child: Text(district.name),
                              );
                            }).toList(),
                            onChanged: _onDistrictChanged,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow:  [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 10),
                      color: Colors.grey.withOpacity(0.2),
                    )
                  ],
                ),
                child: FutureBuilder<List<Ward>>(
                  future: _wards,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField<Ward>(
                            isDense: true,
                            value: _selectedWard,
                            hint: const Text("Chọn Phường/Xã"),
                            items: snapshot.data!.map((ward) {
                              return DropdownMenuItem<Ward>(
                                value: ward,
                                child: Text(ward.name),
                              );
                            }).toList(),
                            onChanged: _onWardChanged,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(height: 15,),
              AppTextField(textEditingController: widget.aptNumberController,
                hintText: "Địa chỉ chi tiết",
                icon:  Icons.location_on,),
            ],
          ),
        ),
      ),
    );
  }
}
