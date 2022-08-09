import 'dart:io';

import 'package:arion/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../service/user_services.dart';
import '../shared/shared.dart';

class UserController extends GetxController with StateMixin {
  var user = Rxn<User>();
  final box = GetStorage();

  Future<void> login(
      {required String username, required String password}) async {
    change(null, status: RxStatus.loading());
    showLoading();

    var result =
        await UserServices().login(username: username, password: password);
    if (result.value != null) {
      user.value = result.value;
      box.write('token', User.token);
      box.write('password', password);
      user.refresh();
      EasyLoading.dismiss();
      change(user, status: RxStatus.success());
      debugPrint("${user.value!.role}");
      if (user.value!.role == 'admin') {
        Get.offAll(() => const DashboardPageAdmin());
      } else {
        Get.offAll(() => const DashboardPage());
      }
    } else {
      EasyLoading.dismiss();
      snackbarCustom(
        title: 'Masuk Gagal',
        message: result.message ?? "No Message",
        typeSnackbar: TypeSnackbar.error,
      );
    }
  }

  Future<void> register({
    required User userRequest,
    required String password,
  }) async {
    change(null, status: RxStatus.loading());

    var result = await UserServices().register(
      user: userRequest,
      password: password,
    );
    if (result.value != null) {
      user.value = result.value;
      box.write('token', User.token);
      box.write('password', password);
      user.refresh();
      change(user, status: RxStatus.success());

      // Get.offAllNamed(Routes.BUYER_MAIN);
    } else {
      snackbarCustom(
        typeSnackbar: TypeSnackbar.error,
        title: 'Daftar Gagal',
        message: result.message ?? "No Message",
      );
    }
  }

  Future<void> getUser() async {
    var result = await UserServices().getUser();
    if (result.value != null) {
      user.value = result.value;
      user.refresh();
      change(user, status: RxStatus.success());
    } else {
      throw Exception("Error on server");
    }
  }

  Future<void> logout() async {
    showLoading();
    // await box.remove('token');
    var result = await UserServices().logout();
    if (result.value != null) {
      await box.remove('token');
      user.value = User();
      EasyLoading.dismiss();

      Get.offAll(() => const LoginPage());
    } else {
      EasyLoading.dismiss();
      snackbarCustom(
        typeSnackbar: TypeSnackbar.error,
        title: 'Terjadi Kesalahan',
        message: "Harap untuk mencoba kembali",
      );
    }
    // await box.remove('token');
  }

  Future<void> updateProfile(User userRequest) async {
    showLoading();
    var result = await UserServices().updateProfile(userRequest);
    if (result.value != null) {
      debugPrint(
          "Name Before Update ${(result.value as User).name}  ${(result.value as User).username}");
      user.value = result.value;

      EasyLoading.dismiss();
      snackbarCustom(
        typeSnackbar: TypeSnackbar.success,
        title: 'Data Berhasil Disimpan',
        message: 'Data telah berhasil disimpan',
      );
    } else {
      EasyLoading.dismiss();
      snackbarCustom(
        typeSnackbar: TypeSnackbar.error,
        title: 'Terjadi Kesalahan',
        message: result.message!,
      );
    }
  }

  Future<void> updatePhotoProfile(File file) async {
    showLoading();
    var result = await UserServices().updatePhotoProfile(file);
    if (result.value != null) {
      user.value = result.value;

      EasyLoading.dismiss();
      snackbarCustom(
        typeSnackbar: TypeSnackbar.success,
        title: 'Foto Profil Berhasi Diubah',
        message: 'Foto profil anda telah berhasil diubah',
      );
    } else {
      EasyLoading.dismiss();
      snackbarCustom(
        typeSnackbar: TypeSnackbar.error,
        title: 'Terjadi Kesalahan',
        message: result.message!,
      );
    }
  }

  Future<void> changeUsername(String username) async {
    showLoading();
    var resultCheckUsername = await UserServices().checkUsername(username);
    if (resultCheckUsername.value != null) {
      User userRequest = user.value!.copyWith(username: username);
      var userResult = await UserServices().updateProfile(userRequest);
      if (userResult.value != null) {
        user.value = userResult.value;
        EasyLoading.dismiss();
        Get.back();
        snackbarCustom(
          typeSnackbar: TypeSnackbar.success,
          title: 'Data Berhasil Disimpan',
          message: 'Data telah berhasil disimpan',
        );
      } else {
        EasyLoading.dismiss();
        snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          title: 'Terjadi Kesalahan',
          message: userResult.message!,
        );
      }
    } else {
      EasyLoading.dismiss();
      snackbarCustom(
        typeSnackbar: TypeSnackbar.error,
        message: resultCheckUsername.message!,
      );
    }
  }
}
