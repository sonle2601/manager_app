
import 'package:get/get.dart';

bool isNotEmpty(String value) {
  return value.isNotEmpty;
}

bool isNotEmptyInt(int value) {
  return value != 0;
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isValidIDNumber(String idNumber) {
  // Kiểm tra xem chuỗi chỉ chứa chữ số và có độ dài là 9
  return RegExp(r'^[0-9]{9,13}$').hasMatch(idNumber);
}

// Hàm kiểm tra tính hợp lệ của số điện thoại
bool isValidPhoneNumber(String phoneNumber) {
  // Bạn có thể thực hiện các kiểm tra khác như độ dài, định dạng số, v.v.
  return phoneNumber.isNotEmpty;
}

bool isValidBirthday(String birthday) {
  return birthday.isNotEmpty;
}

bool isValidAptNumber(String aptNumber) {
  return true;
}


bool isValidAccNumber(String accNumber) {
  // Bạn có thể thực hiện các kiểm tra khác nếu cần
  return true; // Đơn giản là trả về true trong ví dụ này
}
