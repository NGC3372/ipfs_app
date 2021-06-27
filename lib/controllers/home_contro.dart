import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/utils/local_data.dart';

class ControlHome extends GetxController {
  var a = "hello9".obs;

  void setA(String s) {
    a.value = s;
  }

  List downloadedInfo = [];
  void download() async {}

  @override
  void onInit() async {
    await DataUtil.getInstance();
    print(DataUtil.appDocPath);
    super.onInit();
  }
}
