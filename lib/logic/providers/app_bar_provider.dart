import 'package:get/get.dart';

class AppIndex extends GetxController {
  var selectedIndex = 1.obs;
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
