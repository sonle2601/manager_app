import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/parts_model.dart';
import 'package:manage_app/routes/route_name.dart';
import 'package:manage_app/widgets/app_text.dart';

import '../../../view_models/task_view_models/parts_view_model.dart';
import '../../../widgets/parts_list_widget.dart';

class PartsScreen extends StatefulWidget {
  const PartsScreen({super.key});

  @override
  State<PartsScreen> createState() => _PartsScreenState();
}

class _PartsScreenState extends State<PartsScreen> {
  final PartsViewModel partsViewModel = Get.put(PartsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Quản lý bộ phận",
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
      body: Stack(
        children: [
          Obx(() {
            if (partsViewModel.parts.isEmpty) {
              return Center(
                child: CircularProgressIndicator(), // Vòng loading
              );
            } else {
              return ListView.builder(
                itemCount: partsViewModel.parts.length,
                itemBuilder: (context, index) {
                  var part = partsViewModel.parts[index];
                  return PartsListWidget(
                    onTap: (){
                      // print(part.partName);
                      partsViewModel.UpdatePart(part);
                    },
                    title: part.partName.toString(),
                    status: status(part.partStatus!.toInt()),
                  );
                },
              );
            }
          }),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                partsViewModel.isUpdating = false.obs;
                AddPart();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  String status(int status) {
    if (status == 1) {
      return "Đang hoạt động";
    } else {
      return "Ngưng hoạt động";
    }
  }


}

void AddPart() {
 Get.toNamed(RouteName.addParts);
}





