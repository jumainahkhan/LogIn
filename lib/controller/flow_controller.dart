import 'package:get/get.dart';

class FlowController extends GetxController {
  int currentFlow = 1;
  void setFlow(int flow) {
    currentFlow = flow;
    update();
  }
}
