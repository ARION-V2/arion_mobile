import 'dart:io';

import 'package:arion/models/partner.dart';
import 'package:arion/models/user.dart';
import 'package:arion/service/courier_services.dart';
import 'package:arion/shared/shared.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../service/partner_services.dart';

class CourierController extends GetxController with StateMixin {
  var couriers = List<User>.empty().obs;

  Future<void> getAll() async {
    change(null, status: RxStatus.loading());
    var result = await CourierServices().getCourier();

    if (result.value != null) {
      couriers.value = result.value;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> addCourier({
    required User courier,
    String? password,
    File? file,
  }) async {
    showLoading();
    var result = await CourierServices().addOrUpdate(
      user: courier,
      password: password,
      photo: file,
    );
    if (result.value != null) {
      await getAll();
      Get.back();
      if (courier.id != null) {
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data Kurir berhasil diubah");
      } else {
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data Kurir berhasil ditambahkan");
      }
    } else {
      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
    }
    EasyLoading.dismiss();
  }

  Future<void> deleteCourier(User courier) async {
    showLoading();

    var result = await CourierServices().deleteCourier(courier);
    EasyLoading.dismiss();

    if (result.value != null) {
      couriers.value = couriers.where((p0) => courier.id != p0.id).toList();
      Get.back();
      snackbarCustom(
          typeSnackbar: TypeSnackbar.success,
          message: "Data kurir berhasil dihapus");
    } else {
      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
    }
  }
}
