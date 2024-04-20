import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/task/news_feed/select_image.dart';
import 'package:manage_app/view_models/news_view_model.dart';
import 'package:manage_app/widgets/app_text_area.dart';
import 'package:manage_app/widgets/can_cuoc_input.dart';

import '../../../utils/utils.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/button_bottom.dart';

class NewAddScreen extends StatefulWidget {
  const NewAddScreen({super.key});

  @override
  State<NewAddScreen> createState() => _NewAddScreenState();
}

class _NewAddScreenState extends State<NewAddScreen> {
  final newVM = Get.put(NewsViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Thêm tin tức",
          size: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            AppTextArea(
                hintText: "Tiêu đề",
                textEditingController: newVM.titleController.value,
            ),
            SizedBox(height: 15,),
            AppTextArea(
                maxLines: 3,
                hintText: "Nội dung",
                textEditingController: newVM.contentController.value,
            ),
            SizedBox(height: 15,),
            SelectImage(
                text: "Chọn ảnh tin \n( Nếu có )",
                onImageSelected: (p0) {
                  setState(() {
                    newVM.image = p0.toString();
                  });
                },
            ),

          ],
        ),
      ),
      bottomNavigationBar: Obx(() =>
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ButtonButtom(
              loading: newVM.loading.value,
              title: "Thêm mới",
              onPress: () {
                String? validationError = newVM.validate();
                if (validationError != null) {
                  Utils.snackBar("Lỗi", validationError.toString());
                } else {
                  newVM.addNews();
                  Get.back();
                }
              },
            ),
          ),
      ),
    );
  }
}
