import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/parts_view_model.dart';

import '../../../models/parts_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_text_area.dart';
import '../../../widgets/button_bottom.dart';

class AddPartsScreen extends StatefulWidget {
  const AddPartsScreen({super.key});

  @override
  State<AddPartsScreen> createState() => _AddPartsScreenState();
}

class _AddPartsScreenState extends State<AddPartsScreen> {
  final nameController = TextEditingController();
  final textEditingController = TextEditingController();
  bool switchValue = true;




  @override
  Widget build(BuildContext context) {
    final partsVM = Get.put(PartsViewModel());
    // final PartsModel? partData = Get.arguments as PartsModel?;
    // final isUpdating = partData != null;
    String textStatus = 'Đang hoạt động';

    // if (!partsVM.isUpdating.value) {
    //   partsVM.nameController.value.text ='';
    //   partsVM.descriptionController.value.text ='';
    //   partsVM.isUpdating = true.obs;
    // }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Obx(() =>
            AppText(
              text: partsVM.isUpdating.value ? "Sửa bộ phận" : "Tạo bộ phận",
              size: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            partsVM.resetTextField();
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(.20),
          child: Container(
            height: .4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 11, right: 11),
            color: Colors.grey,
          ),
        ),
      ),
      body:  Stack(
          children: [
               SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    AppTextArea(
                      textEditingController: partsVM.nameController.value,
                      hintText: "Tên bộ phận",
                    ),
                    SizedBox(height: 20,),
                    AppTextArea(
                      textEditingController: partsVM.descriptionController.value,
                      hintText: "Mô tả bộ phận",
                      maxLines: 5,
                    ),
                    SizedBox(height: 40,),
                    if (partsVM.isUpdating.value)  Container(
                      margin: EdgeInsets.only(left: 22, right: 22, bottom: 30),
                      child: Row(
                        children: [
                          AppText(
                            text: partsVM.textStatus, color: Colors.black54,
                          ),
                          Switch(
                            value: partsVM.switchValue.value, // Sử dụng giá trị cục bộ
                            onChanged: (bool newValue) {
                              setState(() {
                                partsVM.switchValue.value = newValue;
                                partsVM.textStatus = partsVM.switchValue.value ? "Đang hoạt động" : "Ngưng hoạt động";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
            ),

            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Obx(() =>
                  ButtonButtom(
                    loading: partsVM.loading.value,
                    title: partsVM.isUpdating.value ? "Cập nhật" : "Tạo mới",
                    onPress: () {
                      String? validationError = partsVM.validate(partsVM.nameController.value.text);
                      if (validationError != null) {
                        Utils.snackBar("Lỗi", validationError.toString());
                      } else {
                        if (partsVM.isUpdating.value) {
                          partsVM.UpdatePartApi();
                        } else {
                          partsVM.addApi();
                        }
                        Get.back();
                      }
                    },
                  ),
              ),
            ),
          ],

      ),
    );
  }



}




