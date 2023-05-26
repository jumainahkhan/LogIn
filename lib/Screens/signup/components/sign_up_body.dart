import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/controller/flow_controller.dart';

import 'flow_one.dart';
import 'flow_three.dart';
import 'flow_two.dart';

class SignUpBodyScreen extends StatefulWidget {
  const SignUpBodyScreen({super.key});

  @override
  State<SignUpBodyScreen> createState() => _SignUpBodyScreenState();
}

class _SignUpBodyScreenState extends State<SignUpBodyScreen> {
  FlowController flowController = Get.put(FlowController());
  late int _currentFlow;
  @override
  void initState() {
    _currentFlow = FlowController().currentFlow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#fed8c3"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                        height: 535,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: HexColor("#ffffff"),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: GetBuilder<FlowController>(
                          builder: (context) {
                            if (flowController.currentFlow == 1) {
                              return const SignUpOne();
                            } else if (flowController.currentFlow == 2) {
                              return const SignUpTwo();
                            } else {
                              return const SignUpThree();
                            }
                          },
                        )),
                    Transform.translate(
                        offset: const Offset(0, -253),
                        child: Image.asset(
                          'assets/Images/plants2.png',
                          scale: 1.5,
                          width: double.infinity,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
