import 'package:get/get.dart';

class MyControler extends GetxController {
  int num = 0;

  void changeNum() {
    num++;
    update();
  }
}
