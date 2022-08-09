import 'dart:io';

import 'package:arion/models/partner.dart';
import 'package:arion/models/product.dart';
import 'package:arion/models/user.dart';
import 'package:arion/service/courier_services.dart';
import 'package:arion/service/product_services.dart';
import 'package:arion/shared/shared.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../service/partner_services.dart';

class ProductController extends GetxController with StateMixin {
  var products = List<Product>.empty().obs;

  Future<void> getAll() async {
    change(null, status: RxStatus.loading());
    var result = await ProductServices().getProduct();

    if (result.value != null) {
      products.value = result.value;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> addProduct({
    required Product product,
    File? file,
  }) async {
    showLoading();
    var result = await ProductServices().addOrUpdate(
      product: product,
      photo: file,
    );
    if (result.value != null) {
      await getAll();
      Get.back();
      if (product.id != null) {
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data Produk berhasil diubah");
      } else {
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data Produk berhasil ditambahkan");
      }
    } else {
      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
    }
    EasyLoading.dismiss();
  }

  Future<void> deleteProduct(Product product) async {
    showLoading();

    var result = await ProductServices().deleteProduct(product);
    EasyLoading.dismiss();

    if (result.value != null) {
      products.value = products.where((p0) => product.id != p0.id).toList();
      Get.back();
      snackbarCustom(
          typeSnackbar: TypeSnackbar.success,
          message: "Data Produk berhasil dihapus");
    } else {
      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
    }
  }
}
