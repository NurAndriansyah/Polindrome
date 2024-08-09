import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var selectedUserName = ''.obs;

  void setUserName(String name) {
    userName.value = name;
  }

  void setSelectedUserName(String name) {
    selectedUserName.value = name;
  }
}
