import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/routes/route_name.dart';
import 'package:manage_app/widgets/app_text.dart';
import 'package:manage_app/widgets/app_text_field.dart';
import 'package:manage_app/widgets/icon_and_text.dart';
import 'package:manage_app/widgets/task_container.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: const Align(
                  alignment: Alignment.centerLeft, // Căn chỉnh văn bản về phía trái
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0), // Tạo khoảng cách từ lề trái
                    child: AppText(text: 'Tác vụ',size: 20),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TaskContainer(
                components: [
                  IconAndText(
                    image: 'store.png',
                    text: "Cửa hàng",
                    onTap: (){
                      Get.toNamed(RouteName.updateStoreScreen);
                    },
                  ),
                  IconAndText(
                      image: 'role_staff.png',
                      text: "Bộ phận",
                      onTap: (){
                       Get.toNamed(RouteName.partsScreen);
        },
                  ),
                  IconAndText(
                      image: 'shift.png', text: "Ca làm việc",
                    onTap: (){
                        // print('hi');
                      Get.toNamed(RouteName.workShiftScreen);
                    },
                  ),
                ],
                title: 'Danh mục',
                ),
              TaskContainer(
                components: [
                  IconAndText(
                      image: 'list_staff.png',
                      text: "Danh sách nhân viên",
                      onTap: (){
                        Get.toNamed(RouteName.listEmployeeScreen);
                      },
                  ),
                  IconAndText(
                      image: 'add_staff.png',
                      text: "Thêm nhân viên",
                    onTap: (){
                      Get.toNamed(RouteName.inviteEmployeeForm);
                    },
                  ),
                ],
                title: 'Nhân viên',
              ),
              TaskContainer(
                components: [
                  IconAndText(
                    onTap: (){
                      Get.toNamed(RouteName.commonWorkScheduleScreen);
                    },
                      image: 'xem_lich.png',
                      text: "Xem lich làm việc"
                  ),
                  IconAndText(
                      onTap: (){
                        Get.toNamed(RouteName.workScheduleScreen);
                      },
                      image: 'sap_xep_lich.png',
                      text: "Sắp xếp lịch làm việc"),
                  // IconAndText(image: 'duyet_lich.png', text: "Duyệt lịch làm việc"),
                ],
                title: 'Lịch làm việc',
              ),
              TaskContainer(
                components: [
                  IconAndText(
                      onTap: (){
                        Get.toNamed(RouteName.listAttendanceScreen);
                      },
                      image: 'danh_sach_cham_cong.png', text: "Danh sách chấm công"
                  ),
                  // IconAndText(image: 'duyet_cham_cong.png', text: "Duyệt chấm công"),
                  IconAndText(
                    onTap: (){
                      Get.toNamed(RouteName.timeClockDeviceForm);
                    },
                      image: 'thiet_bi_cham_cong.png',
                      text: "Thiết bị chấm công"),
                ],
                title: 'Chấm công',
              ),
              TaskContainer(
                components: [
                  IconAndText(
                    onTap: (){
                      Get.toNamed(RouteName.saralyListScreen);
                    },
                      image: 'salary.png',
                      text: "Lương ước tính"
                  ),
                  // IconAndText(image: 'sua_luong.png', text: "Cấu hình lương"),
                  IconAndText(
                      onTap: (){
                        Get.toNamed(RouteName.salaryBonusListScreen);
                      },
                      image: 'thuong.png',
                      text: "Lương thưởng"
                  ),
                  IconAndText(
                      onTap: (){
                        Get.toNamed(RouteName.salaryPenaltyListScreen);
                      },
                      image: 'phat.png',
                      text: "Lương phạt"),
                  // IconAndText(image: 'quy.png', text: "Quỹ nhân viên"),
                ],
                title: 'Lương nhân viên',
              ),
              // TaskContainer(
              //   components: [
              //     IconAndText(image: 'tong_quan.png', text: "Tổng quan nhân viên"),
              //     IconAndText(image: 'nang_suat.png', text: "Hiệu suất làm việc"),
              //     IconAndText(image: 'di_muon.png', text: "Đi muộn về sớm"),
              //   ],
              //   title: 'Báo cáo',
              // ),
              TaskContainer(
                components: [
                  // IconAndText(image: 'luat.png', text: "Nội quy"),
                  IconAndText(
                    onTap: (){
                      Get.toNamed(RouteName.newsListScreen);
                    },
                      image: 'thong_bao.png',
                      text: "Thông báo"),
                ],
                title: 'Tin tức',
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
