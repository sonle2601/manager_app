import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/widgets/app_text.dart';

import '../../../models/store_model.dart';
import '../../../utils/utils.dart';
import '../../../view_models/store_view_models.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/location_widget.dart';
import '../../../widgets/round_button.dart';

class UpdateStoreScreen extends StatefulWidget {
  const UpdateStoreScreen({super.key});

  @override
  State<UpdateStoreScreen> createState() => _UpdateStoreScreenState();
}

class _UpdateStoreScreenState extends State<UpdateStoreScreen> {
  final StoreViewModel storeVM = StoreViewModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreModel>(
      future: storeVM.getInforStore(),
      builder: (BuildContext context, AsyncSnapshot<StoreModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          StoreModel store = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 65,
              backgroundColor: Colors.white,
              elevation: 0,
              title: AppText(
                text: "Cập nhật điểm bán",
                size: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(.20),
                child: Container(
                  height: .4,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  color: Colors.grey,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        AppTextField(
                          textEditingController: TextEditingController(text: store.ten),
                          hintText: "Tên điểm bán",
                          icon: Icons.shop,
                        ),
                        SizedBox(height: 20),
                        AppTextField(
                          textEditingController: TextEditingController(text: store.soDienThoai),
                          hintText: "Số điện thoại",
                          icon: Icons.phone,
                        ),
                        SizedBox(height: 20),
                        LocationWidget(
                          aptNumberController: TextEditingController(text: store.chiTiet),
                          initProvince: store.thanhPho,
                          initDistrict: store.huyen,
                          initWard: store.xa,
                          onLocationSelected: (String? cityName, String? districtName, String? wardName) {
                            // Xử lý khi có thông tin về tỉnh/thành phố, quận/huyện và phường/xã được chọn
                            storeVM.selectedCity = cityName ?? '';
                            storeVM.selectedDistrict = districtName ?? '';
                            storeVM.selectedWard = wardName ?? '';
                          },
                        ),



                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Obx(() => RoundButton(
                  width: 350,
                  title: 'Cập nhật',
                  loading: storeVM.loading.value,
                  onPress: () {
                    String? validationError = storeVM.validateStore(
                      store.ten.toString(),
                      store.soDienThoai.toString(),
                      storeVM.selectedCity.toString(),
                      storeVM.selectedDistrict.toString(),
                      storeVM.selectedWard.toString(),
                      store.chiTiet.toString(),
                    );
                    if (validationError != null) {
                      Utils.snackBar("Lỗi", validationError.toString());
                    } else {
                      storeVM.storeApi();
                    }
                  },
                )),
              ],
            ),
          );
        }
      },
    );
  }
}
