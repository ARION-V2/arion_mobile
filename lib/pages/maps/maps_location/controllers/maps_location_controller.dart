import 'dart:math';

import 'package:arion/controller/location_controller.dart';
import 'package:arion/models/delivery.dart';
import 'package:arion/models/mapping_delivery.dart';
import 'package:arion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;

import '../../../../service/direction_services.dart';

class MapsLocationController extends GetxController with StateMixin {
  final locationController = Get.find<LocationController>();
  var mapsController = Rxn<GoogleMapController>();
  var markers = Rx<Set<Marker>>({});
  var polinines = Rx<Set<Polyline>>({});
  CameraPosition? cameraPosition;
  var initialPosition = const LatLng(-6.884556, 108.304353);
  var currentListDeliveries = List<MappingDelivery>.empty().obs;
  var currentListPlusDirection = List<MappingDelivery>.empty().obs;
  var myLocation = Rxn<LatLng>();

  List<Marker> listMarker = [];

  List<MappingDelivery> fullDirection = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      MapLocationArgument argument = Get.arguments;
      currentListDeliveries.value = argument.deliveries;
      debugPrint("Total Delivery di Map: ${ currentListDeliveries.length}");
      var gudang = argument.deliveries.firstWhereOrNull((element) => element.fromGudang!=null);
      initialPosition = LatLng(double.parse(gudang!.fromGudang!.latitude!), double.parse(gudang.fromGudang!.longitude!));
      myLocation.value = LatLng(double.parse(gudang.fromGudang!.latitude!), double.parse(gudang.fromGudang!.longitude!));
      // currentListPlusDirection.value = argument.deliveryPlusDirection;
    }
    // markers.value.add(
    //   Marker(
    //     markerId: MarkerId(
    //       myLocation.toString(),
    //     ),
    //     position: myLocation.value!,
    //     infoWindow: const InfoWindow(
    //       title: "Lokasi Gudang",

    //     ),
    //   ),
    // );
    debugPrint("Jumlah Lokasi ${currentListDeliveries.length}");

    getDirection();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    mapsController.value!.dispose();
  }

  void getDirection() async {
    change(null, status: RxStatus.loading());
    try {
      for (var delivery in currentListDeliveries) {
        final request = await DirecticonServices().getDirection(
          origin:(delivery.fromGudang!=null)? LatLng(double.parse(delivery.fromGudang!.latitude!), double.parse(delivery.fromGudang!.longitude!)):delivery.fromDelivery!.partner!.locationLatLng,
          destination:(delivery.toGudang!=null)? LatLng(double.parse(delivery.toGudang!.latitude!), double.parse(delivery.toGudang!.longitude!)):delivery.nextDelivery!.partner!.locationLatLng,
        );
        debugPrint("result Direction: ${request.value}");
        fullDirection.add(
          delivery.copyWith(direction: request.value),
        );
      }
      // polinines.value.add(
      //   Polyline(
      //       polylineId: PolylineId("MyLocation"),
      //       color: Colors.blue,
      //       points: e.direction!.polylinePoints
      //           .map(
      //             (e) => LatLng(
      //               e.latitude,
      //               e.longitude,
      //             ),
      //           )
      //           .toList(),
      //       onTap: () {
      //         Get.dialog(
      //           ShowDialongComfirm(
      //             onConfirmOk: () {
      //               Get.back();
      //             },
      //             textMessage: e.direction!.totalDistance,
      //           ),
      //         );
      //       }),
      // );
      polinines.value.addAll(fullDirection
          .map(
            (e) => Polyline(
                polylineId: PolylineId(Random().nextInt(100).toString()),
                color: Colors.blue,
                points: e.direction!.polylinePoints
                    .map(
                      (e) => LatLng(
                        e.latitude,
                        e.longitude,
                      ),
                    )
                    .toList(),
                onTap: () {
                  Get.dialog(
                    ShowDialongComfirm(
                      onConfirmOk: () {
                        Get.back();
                      },
                      textMessage: e.direction!.totalDistance,
                    ),
                  );
                }),
          )
          .toList());
      //       fullDirection.sort((a, b) =>
      // a.direction!.distance!.compareTo(b.nextDelivery!.distance!));

      for (var i = 0; i < fullDirection.length; i++) {
        markers.value.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position:(fullDirection[i].fromGudang!=null)?LatLng(double.parse(fullDirection[i].fromGudang!.latitude!), double.parse(fullDirection[i].fromGudang!.longitude!)): fullDirection[i].fromDelivery!.partner!.locationLatLng,
            infoWindow: InfoWindow(
              title:(fullDirection[i].fromGudang!=null)?fullDirection[i].fromGudang!.namaGudang: fullDirection[i].fromDelivery!.partner!.marketName,
              snippet:
                  "Tujuan Berikutnya :${(fullDirection[i].toGudang!=null)?fullDirection[i].toGudang!.namaGudang:fullDirection[i].nextDelivery!.partner!.marketName}",
            ),
            icon: (fullDirection[i].fromGudang!=null)?BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan):BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
          ),
        );
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.success());
    }
  }

  onMapCreated(GoogleMapController thisController) {
    mapsController.value = thisController;
  }

  Marker buildMarker(LatLng position) {
    return Marker(
      markerId: const MarkerId(
        "sourcePin",
      ),
      position: position,
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  CameraPosition cameraPositionCustom(LatLng target) {
    return CameraPosition(target: target, zoom: 15);
  }

  void redirectToMaps() async {
    final availableMaps = await mapLauncher.MapLauncher.installedMaps;
    await availableMaps.first.showDirections(
      destination: mapLauncher.Coords(
          initialPosition.latitude, initialPosition.longitude),
      destinationTitle: "Warung Dadan",
      directionsMode: mapLauncher.DirectionsMode.driving,
    );
  }
}

class MapLocationArgument {
  final List<MappingDelivery> deliveries;
  // final List<MappingDelivery> deliveryPlusDirection;
  MapLocationArgument({
    required this.deliveries,
    // required this.deliveryPlusDirection,
  });
}
