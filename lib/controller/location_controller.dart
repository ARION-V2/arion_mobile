

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../shared/shared.dart';

class LocationController  extends GetxController with StateMixin {

  var myLocation = Rxn<LatLng>();
   Future<void> searchMyLocation({bool isLoading = true}) async {
    try {
      Location location = Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          throw Exception("Service Not Enable");
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          throw Exception("Permission Not Denied");
        }
      }
      if (isLoading) {
        showLoading();
      }
      _locationData = await location.getLocation();

      debugPrint("Titik Lokasi pusat: $_locationData");
      // myLocation.value = const LatLng(-6.400290, 108.284460);

      myLocation.value =
          LatLng(_locationData.latitude!, _locationData.longitude!);

      EasyLoading.dismiss();
    } catch (e) {
      myLocation.value = const LatLng(-6.400290, 108.284460);
      EasyLoading.dismiss();
    }
  }
}