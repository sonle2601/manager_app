import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/store_view_models.dart';
import 'package:manage_app/widgets/app_text_field.dart';
import 'package:manage_app/widgets/location_widget.dart';

import '../../../utils/utils.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/round_button.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreen();
}

class _StoreScreen extends State<StoreScreen> {
  final  nameController = TextEditingController();
  final aptNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StoreViewModel storeVM = StoreViewModel();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Center(child: BigText(text: "Hãy thông tin điểm bán", size: 25,color: Colors.black,)),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: 400,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lightBlueAccent
              ),
              child: Center(
                child: Text("Vui lòng hoàn thiện với đầy đủ thông tin cửa hàng",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 16
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30,),
            AppTextField(
                textEditingController: storeVM.name.value,
                hintText: "Tên điểm bán",
                icon: Icons.shop),
            SizedBox(height: 20,),
            AppTextField(
              keyboardType: TextInputType.phone,
                textEditingController: storeVM.phoneNumber.value,
                hintText: "Số điện thoại",
                icon: Icons.phone),
            SizedBox(height: 20,),
            LocationWidget(
              aptNumberController: storeVM.aptNumber.value,
              onLocationSelected: (String? cityName, String? districtName, String? wardName) {
                // Kiểm tra và lưu trữ giá trị null khi chưa được chọn
                storeVM.selectedCity = cityName ?? '';
                storeVM.selectedDistrict = districtName ?? '';
                storeVM.selectedWard = wardName ?? '';
              },
            ),
            SizedBox(height: 30,),
            Obx(() => RoundButton(
            width: 350,
            title: 'Xác nhận',
            loading: storeVM.loading.value,
            onPress: (){
              String? validationError = storeVM.validateStore(
                storeVM.name.value.text,
                storeVM.phoneNumber.value.text,
                storeVM.selectedCity.toString(),
                storeVM.selectedDistrict.toString(),
                storeVM.selectedWard.toString(),
                storeVM.aptNumber.value.text,
              );
              if (validationError != null) {
                Utils.snackBar("Lỗi", validationError.toString());
              } else {
                storeVM.storeApi();
              }
            }
        ),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
