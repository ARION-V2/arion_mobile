import 'dart:io';
import 'dart:math';

import 'package:arion/controller/location_controller.dart';
import 'package:arion/models/Tsp_anneling.dart';
import 'package:arion/models/delivery.dart';
import 'package:arion/models/gudang.dart';
import 'package:arion/models/mapping_delivery.dart';
import 'package:arion/service/anneling_services.dart';
import 'package:arion/service/delivery_services.dart';
import 'package:arion/service/direction_services.dart';
import 'package:arion/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryController extends GetxController with StateMixin {
  var deliveries = List<Delivery>.empty().obs;
  final locationController = Get.find<LocationController>();
  var waitingDeliveriesModel = List<Delivery>.empty().obs;
  var doneDeliveriesModel = List<Delivery>.empty().obs;

  var resultMapping = List<MappingDelivery>.empty().obs;

  var gudang = Rxn<Gudang>();
  var resultMatrix = Rxn<TspAnnaling>();
  var loadingMapping = false.obs;

  Future<void> getAll({
    String? status,
    bool isNotDone = false,
  }) async {
    change(null, status: RxStatus.loading());
    var result = await DeliveryServices().getDelivery(
      status: status,
      isNotDone: isNotDone,
    );

    if (result.value != null) {
      deliveries.value = result.value;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> runAnneling() async {
    var result = await AnnelingServices().runAnneling(
        nameGundang: "-6.408288,108.281561",
        destinations: waitingDeliveriesModel
            .map((element) => element.koordinateString)
            .toList());
    if (result.value != null) {
      List<MappingDelivery> resultListMapping = [];
      TspAnnaling resultFix = result.value;
      resultMatrix.value =resultFix;
      for (var i = 0; i < resultFix.urutanTujuan!.length; i++) {
        if (i == 0) {
          resultListMapping.add(
            MappingDelivery(
              distance: resultFix.urutanTujuan![i].jarak,
              fromGudang: Gudang(
                  id: 1,
                  namaGudang: "Ini Gudang",
                  latitude: "-6.408288",
                  longitude: "108.281561"),
              nextDelivery: waitingDeliveriesModel.firstWhere((element) =>
                  element.koordinateString ==
                  resultFix.urutanTujuan![i].toAddresses),
            ),
          );
        } else if (i == resultFix.urutanTujuan!.length - 1) {
          resultListMapping.add(
            MappingDelivery(
                distance: resultFix.urutanTujuan![i].jarak,
                toGudang: Gudang(
                    id: 1,
                    namaGudang: "Ini Gudang",
                    latitude: "-6.408288",
                    longitude: "108.281561"),
                fromDelivery: waitingDeliveriesModel.firstWhere((element) =>
                    element.koordinateString ==
                    resultFix.urutanTujuan![i].fromAddress)),
          );
        } else {
          resultListMapping.add(
            MappingDelivery(
              distance: resultFix.urutanTujuan![i].jarak,
              fromDelivery: waitingDeliveriesModel.firstWhere((element) =>
                  element.koordinateString ==
                  resultFix.urutanTujuan![i].fromAddress),
              nextDelivery: waitingDeliveriesModel.firstWhere((element) =>
                  element.koordinateString ==
                  resultFix.urutanTujuan![i].toAddresses),
            ),
          );
        }
        resultMapping.value = resultListMapping;
      }
    }
  }

  Future<void> getGudang() async {}

  Future<void> getWaitingDelivery({
    String? status,
    bool isNotDone = false,
  }) async {
    change(null, status: RxStatus.loading());
    var result = await DeliveryServices().getDelivery(
      isNotDone: true,
    );

    if (result.value != null) {
      waitingDeliveriesModel.value = result.value;
      await runAnneling();
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> getDoneDeliveries({
    String? status,
    bool isNotDone = false,
  }) async {
    change(null, status: RxStatus.loading());
    var result = await DeliveryServices().getDelivery(
      status: "Berhasil",
    );

    if (result.value != null) {
      doneDeliveriesModel.value = result.value;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<Delivery?> addDelivery({
    required Delivery delivery,
    File? file,
  }) async {
    showLoading();
    var result = await DeliveryServices().addUpdateDelivery(
      delivery: delivery,
      photoFile: file,
    );
    if (result.value != null) {
      if (delivery.id == null) {
        await getAll();
        Get.back();
        Get.back();
        Get.back();
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data Pengiriman berhasil ditambahkan");
      } else {
        deliveries.value = deliveries.map((element) {
          if (element.id == delivery.id) {
            return result.value as Delivery;
          } else {
            return element;
          }
        }).toList();
        snackbarCustom(
            typeSnackbar: TypeSnackbar.success,
            message: "Data Pengiriman diubah");
      }
      EasyLoading.dismiss();

      return result.value;
    } else {
      EasyLoading.dismiss();

      snackbarCustom(
          typeSnackbar: TypeSnackbar.error,
          message: "ERROR : ${result.message}");
      return null;
    }
  }

  Future<void> deleteDelivery(Delivery delivery) async {
    showLoading();

    var result = await DeliveryServices().deleteDelivery(delivery);
    EasyLoading.dismiss();

    if (result.value != null) {
      deliveries.value =
          deliveries.where((p0) => delivery.id != p0.id).toList();
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

  void mappingDirection() async {
    loadingMapping.value = true;
    LatLng myLocation = locationController.myLocation.value!;

    List<Delivery> resultLoop1;

    for (var element in waitingDeliveriesModel) {
      final request = await DirecticonServices().getDirection(
        origin: myLocation,
        destination: LatLng(
          double.parse(element.partner!.latitude!),
          double.parse(element.partner!.longitude!),
        ),
      );
      debugPrint("Masuk 2");
      if (request.value != null) {
        waitingDeliveriesModel.value = waitingDeliveriesModel.map((e) {
          if (e.id == element.id) {
            return e.copyWith(direction: request.value);
          } else {
            return e;
          }
        }).toList();
      }
    }

    waitingDeliveriesModel.sort(
      (a, b) => a.direction!.distanceToDouble
          .compareTo(b.direction!.distanceToDouble),
    );
    debugPrint("Masuk 4");

    loadingMapping.value = false;
  }

  void mappingDirection2() async {
    change(null, status: RxStatus.loading());
    LatLng myLocation = locationController.myLocation.value!;
    List<Delivery> fullResult = [];
    for (var i = 0; i < waitingDeliveriesModel.length; i++) {
      List<Delivery> resultSementara = [];
      for (var j = 0; j < waitingDeliveriesModel.length; j++) {
        if (waitingDeliveriesModel[i].id != waitingDeliveriesModel[j].id) {
          double distanceInKm = await hitungJarak(
            (i == 0)
                ? LatLng(myLocation.latitude, myLocation.longitude)
                : LatLng(
                    double.parse(waitingDeliveriesModel[i].partner!.latitude!),
                    double.parse(waitingDeliveriesModel[i].partner!.longitude!),
                  ),
            (i == waitingDeliveriesModel.length - 1)
                ? LatLng(myLocation.latitude, myLocation.longitude)
                : LatLng(
                    double.parse(waitingDeliveriesModel[j].partner!.latitude!),
                    double.parse(
                      waitingDeliveriesModel[j].partner!.longitude!,
                    ),
                  ),
          );
          debugPrint("Jarak $i $j = $distanceInKm");
          if (fullResult
              .where((element) =>
                  element.nextDeliveryId == waitingDeliveriesModel[j].partnerId)
              .toList()
              .isEmpty) {
            debugPrint("Masuk Nihh yang jaraknya $i $j = $distanceInKm");

            resultSementara.add(
              waitingDeliveriesModel[j].copyWith(
                nextDeliveryId: (i == waitingDeliveriesModel.length - 1)
                    ? 0
                    : waitingDeliveriesModel[j].partnerId,
                distance: distanceInKm,
                nameFromDeliveryPartner: (i == 0)
                    ? "Lokasi Anda"
                    : waitingDeliveriesModel[i].partner!.marketName,
                nameNextDeliveryPartner:
                    (i == waitingDeliveriesModel.length - 1)
                        ? "Lokasi Anda"
                        : waitingDeliveriesModel[j].partner!.marketName,
                fromLatLngDelivery: (i == 0)
                    ? LatLng(myLocation.latitude, myLocation.longitude)
                    : LatLng(
                        double.parse(
                            waitingDeliveriesModel[i].partner!.latitude!),
                        double.parse(
                            waitingDeliveriesModel[i].partner!.longitude!),
                      ),
                nextLatLngDelivery: (i == waitingDeliveriesModel.length - 1)
                    ? LatLng(myLocation.latitude, myLocation.longitude)
                    : LatLng(
                        double.parse(
                            waitingDeliveriesModel[j].partner!.latitude!),
                        double.parse(
                          waitingDeliveriesModel[j].partner!.longitude!,
                        ),
                      ),
              ),
            );
          }
        }
      }
      resultSementara.sort(
        ((a, b) => a.distance!.compareTo(b.distance!)),
      );
      debugPrint("Distance yang diambil : ${resultSementara.first.distance}");
      fullResult.add(resultSementara.first);
    }
    waitingDeliveriesModel.value = fullResult;
    debugPrint("Total Route ${fullResult.length}");
    change(waitingDeliveriesModel, status: RxStatus.success());
  }

  void mappingDirection3() async {
    change(null, status: RxStatus.loading());
    LatLng myLocation = locationController.myLocation.value!;
    List<Delivery> fullResult = [];
    for (var i = 0; i < waitingDeliveriesModel.length; i++) {
      List<Delivery> resultSementara = [];
      for (var j = 0; j < waitingDeliveriesModel.length; j++) {
        if (waitingDeliveriesModel[i].id != waitingDeliveriesModel[j].id) {
          double jarak = await hitungJarak(
            (i == 0)
                ? myLocation
                : LatLng(
                    double.parse(waitingDeliveriesModel[i].partner!.latitude!),
                    double.parse(waitingDeliveriesModel[i].partner!.longitude!),
                  ),
            (i == waitingDeliveriesModel.length - 1)
                ? myLocation
                : (i == 0)
                    ? LatLng(
                        double.parse(
                            waitingDeliveriesModel[i + 1].partner!.latitude!),
                        double.parse(
                            waitingDeliveriesModel[i + 1].partner!.longitude!),
                      )
                    : LatLng(
                        double.parse(
                            waitingDeliveriesModel[j].partner!.latitude!),
                        double.parse(
                            waitingDeliveriesModel[j].partner!.longitude!),
                      ),
          );

          resultSementara.add(
            waitingDeliveriesModel[j].copyWith(),
          );
        }
      }
    }
    change(waitingDeliveriesModel, status: RxStatus.success());
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<double> hitungJarak(LatLng awal, LatLng akhir) async {
    PolylinePoints polylinePoints = PolylinePoints();

    String googleAPiKey = "AIzaSyCXEykmj3RsEDFNBrLCmA-lmxKCWqT-zCI";

    Set<Marker> markers = Set(); //markers for google map
    Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

    LatLng startLocation = awal;
    LatLng endLocation = akhir;

    double distance = 0.0;

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

//polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }

    return totalDistance;
  }
}
