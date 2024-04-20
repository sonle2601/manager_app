import 'package:intl/intl.dart';

class FormatUtils{

  static String formatNumberWithCommas(String number) {
    // Tách phần nguyên và phần thập phân
    List<String> parts = number.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? '.' + parts[1] : '';

    // Xử lý phần nguyên
    String formattedInteger = '';
    int count = 0;
    for (int i = integerPart.length - 1; i >= 0; i--) {
      formattedInteger = integerPart[i] + formattedInteger;
      count++;
      if (count % 3 == 0 && i != 0) {
        formattedInteger = ',' + formattedInteger;
      }
    }

    // Kết hợp phần thập phân nếu có
    String formattedNumber = formattedInteger + (decimalPart == '.00' ? '' : decimalPart);

    return formattedNumber;
  }

  static  String formatDateString(String? dateString) {
    if (dateString == null) return ''; // Trả về chuỗi trống nếu dateString là null
    DateTime parsedDate = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  static String convertMinutesToHoursAndMinutes(int? minutes) {
    if(minutes == null || minutes < 0){
      return '0 phút';
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours > 0 && remainingMinutes > 0) {
      return '$hours giờ $remainingMinutes phút';
    } else if (hours > 0 && remainingMinutes == 0) {
      return '$hours giờ';
    } else {
      return '$remainingMinutes phút';
    }
  }

  static String timeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years năm trước';
    } else if (difference.inDays > 30) {
      int months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}