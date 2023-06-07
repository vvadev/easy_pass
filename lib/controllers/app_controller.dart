import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  String appVersion = '';

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getPackageInfo();
  }
}
