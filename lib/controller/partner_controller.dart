import 'package:arion/models/partner.dart';
import 'package:arion/shared/shared.dart';
import 'package:get/get.dart';

import '../service/partner_services.dart';

class PartnerController extends GetxController with StateMixin {
  var partners = List<Partner>.empty().obs;

  Future<void> getAllPartner() async {
    change(null, status: RxStatus.loading());
    var result = await PartnerServices().getPartners();

    if (result.value != null) {
      partners.value = result.value;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> addPartner(Partner partner) async {
    var result = await PartnerServices().addUpdatePartners(partner);
    if (result.value != null) {
   
      await getAllPartner();
      Get.back();
      if (partner.id != null) {
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data mitra berhasil diubah");
      } else {
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data mitra berhasil ditambahkan");
      }
      
    } else {
      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
    }
  }

   Future<void> deletePartner(Partner partner) async {
    var result = await PartnerServices().deletePartners(partner);
    if (result.value != null) {
      partners.value = partners.where((p0) => partner.id!= p0.id).toList();
      Get.back();
      snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data mitra berhasil dihapus");
      
    } else {
      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
    }
  }
}
