import 'package:arion/controller/user_controller.dart';
import 'package:arion/pages/pages.dart';
import 'package:arion/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WrapperLogin extends StatelessWidget {
  WrapperLogin({Key? key}) : super(key: key);
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    userController.getUser();
    return Obx(() => (userController.user.value != null)
        ? (userController.user.value!.role == 'admin')
            ? const DashboardPageAdmin()
            : const DashboardPage()
        : Scaffold(
            body: Center(
              child: loading(4),
            ),
          ));
  }
}
