import 'package:get/get.dart';

class AutomationController extends GetxController {
  var isAutomationEnabled = List<bool>.filled(10, false).obs;

  void toggleAutomation(int index, bool value) {
    isAutomationEnabled[index] = value;
  }
}
