import 'package:flutter/material.dart';
import 'package:manage_app/widgets/app_text_area.dart';
import 'package:manage_app/widgets/select_item/select_location.dart';
import 'package:manage_app/widgets/select_item/select_location/select_district.dart';
import 'package:manage_app/widgets/select_item/select_location/select_ward.dart';
import 'package:manage_app/widgets/select_item/title_icon_select.dart';

import '../../utils/utils.dart';

class SelectAddress extends StatefulWidget {
  final String? addressSelected;
   const SelectAddress({super.key, required this.onLocationSelected, this.addressSelected});
  final void Function(String?) onLocationSelected;



  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {



  final  aptNumberController = TextEditingController();


  String selectedProvince = "Chọn Tỉnh/ Thành phố";
  String? idProvinceSelected;
  String selectedDistrict = "Chọn Quận/ Huyện";
  String? idDistrictSelected;
  String selectedWard =  "Chọn Phường/ Xã";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.addressSelected != null) {
      List<String> addressSelected = widget.addressSelected!.split(',');
      aptNumberController.value = TextEditingValue(text: addressSelected[0].trim());
      selectedProvince =addressSelected[3].trim();
      selectedDistrict =addressSelected[2].trim();
      selectedWard =addressSelected[1].trim();
    } else {
       selectedProvince = "Chọn Tỉnh/ Thành phố";
       selectedDistrict = "Chọn Quận/ Huyện";
       selectedWard =  "Chọn Phường/ Xã";
       aptNumberController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  SelectProvince.showSelectProvince(context, (idProvince, nameProvince) {
                    setState(() {
                      idProvinceSelected = idProvince;
                      selectedProvince = nameProvince;
                    });
                  });
                },
                child: TitleIconSelect(name: selectedProvince,title: "Tỉnh/Thành phố", icon: Icons.location_city,),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  if (idProvinceSelected != null) {
                    SelectDistrict.showSelectDistricts(context, idProvinceSelected!, (id, name) {
                      setState(() {
                        idDistrictSelected = id;
                        selectedDistrict = name;
                      });

                    });
                  } else {
                    Utils.toastMessage( "Vui lòng chọn tỉnh/ thành phố trước");
                  }
                },
                child: TitleIconSelect(
                  name: selectedDistrict,
                  title: "Quận/ Huyện",
                  icon: Icons.location_city,
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  if (idDistrictSelected != null) {
                    SelectWard.showSelectWard(context, idDistrictSelected!, (nameWard) {
                      setState(() {
                        selectedWard = nameWard;
                      });
                    });
                  } else {
                    Utils.toastMessage( "Vui lòng chọn quận/ huyện trước");
                  }
                },
                child: TitleIconSelect(
                  name: selectedWard,
                  title: "Phường / Xã",
                  icon: Icons.location_city,
                ),
              ),
              SizedBox(height: 20,),
              AppTextArea(
                keyboardType: TextInputType.text,
                hintText: "Địa chỉ chi tiết",
                textEditingController: aptNumberController,
                onEditingComplete: () {
                  if (selectedProvince != "Chọn Tỉnh/ Thành phố" &&
                      selectedDistrict != "Chọn Quận/ Huyện" &&
                      selectedWard != "Chọn Phường/ Xã" &&
                      aptNumberController.text.isNotEmpty) {
                    // Kết hợp các giá trị từ các trường thành một địa chỉ hoàn chỉnh
                    String address = "${aptNumberController.text},$selectedWard, $selectedDistrict, $selectedProvince";
                    widget.onLocationSelected(address);
                  }
                },
              ),
            ],
          ),
    );
  }
}
