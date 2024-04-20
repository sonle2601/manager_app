
class AppUrl{
  static const String baseUrl = "http://192.168.1.14:8001/api";

  static const String login = "$baseUrl/login";

  static const String register = "$baseUrl/register";

  static const String infomation = "$baseUrl/information";

  static const String store = "$baseUrl/store";

  static const String checkStore = "$baseUrl/check-store";

  static const String checkInfor = "$baseUrl/check-information";

  static const String getUser = "http://192.168.1.6:8001/api/users";

  static const String baseUlrLocation = "https://vapi.vnappmob.com/api";

  static const String getProvinces = "$baseUlrLocation/province";

  static String getDistricts(String provinceId) => "$baseUlrLocation/province/district/$provinceId";

  static String getWards(String districtId)=> "$baseUlrLocation/province/ward/$districtId";

  static String  part = '$baseUrl/part';

  static String  updatePart = '$baseUrl/update_part';

  static String  workShift = '$baseUrl/work-shift';

  static String  employee = '$baseUrl/employee';

  static String  employeeById(int id) => '$baseUrl/employees/$id';

  static String employeeAvailable(String work_shift_id, String date) => '$baseUrl/available_employees/$work_shift_id/$date';


  static String employeeAccept = '$baseUrl/employee_accept';

  static String workSchedule( String date) => '$baseUrl/work_schedule/$date';

  static String workScheduleAdd = '$baseUrl/work_schedule';

  static String timeClockDevice = '$baseUrl/time_clock_device';

  static String leaveRequets = '$baseUrl/leave-request';

  static String lateEarlyRequets = '$baseUrl/late-early-request';

  static String  attendance(String employeeId) => '$baseUrl/attendance/$employeeId';

  static String  attendanceRequest=  '$baseUrl/attendance-request';

  static String exitRequest = '$baseUrl/exit-request';

  static String salaryBonus = '$baseUrl/salary-bonus';

  static String salaryPenalty = '$baseUrl/salary-penalty';

  static String  salary(String startDate,String endDate,String employeeId) => '$baseUrl/salary/$startDate/$endDate/$employeeId';

  static String notification = '$baseUrl/notification';

  static String news = '$baseUrl/news';

  static String newsDelete(String id) => '$baseUrl/news/$id';

  static String changePassword = '$baseUrl/change-password';


  static const String infomationUser = "$baseUrl/information-user";

  static const String updateInfoUser = "$baseUrl/information-personal";


}