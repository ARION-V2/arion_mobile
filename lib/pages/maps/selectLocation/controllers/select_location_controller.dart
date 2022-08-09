import 'package:arion/pages/maps/searchLocation/bindings/search_location_binding.dart';
import 'package:arion/pages/maps/searchLocation/views/search_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../../../../shared/shared.dart';
import '../../../../shared/variable_const.dart';
import '../../../pages.dart';

//Argumen: initialLocation
class SelectLocationController extends GetxController {
  var initialLocation = const LatLng(-6.175441, 106.827008).obs;

  late GoogleMapController controllerMap;

  late CameraPosition kGooglePlex;
  var customMarkers = List<Marker>.empty().obs;
  late BitmapDescriptor pinLocation;
  var fullAddressName = "".obs;
  var streetAddressName = "".obs;
  var isAddressLoading = false.obs;
  String postalCode = "";
  var searchText = "Cari Alamat".obs;

  var onMoveCamera = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['initialLocation'] != null) {
        kGooglePlex = cameraPositionCustom(Get.arguments['initialLocation']);
      } else {
        kGooglePlex = cameraPositionCustom(const LatLng(-6.175441, 106.827008));
      }
    } else {
      kGooglePlex = cameraPositionCustom(const LatLng(-6.175441, 106.827008));
    }
    // setCustomMapPin();
  }

  @override
  void onClose() {
    controllerMap.dispose();
  }

  Marker buildMarker(LatLng position) {
    return Marker(
      markerId: const MarkerId(
        "sourcePin",
      ),
      position: position,
      icon: pinLocation,
    );
  }

  CameraPosition cameraPositionCustom(LatLng target) {
    return CameraPosition(target: target, zoom: 18);
  }

  setCustomMapPin() async {
    pinLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          devicePixelRatio: 1.5,
          size: Size(40, 60),
        ),
        'assets/icons/pin_maps.png');
    // customMarkers.add(
    //   buildMarker(kGooglePlex.target),
    // );
    await searchAddress();
    return true;
  }

  Future<void> searchAddress() async {
    isAddressLoading.value = true;
    List<Placemark> result = await placemarkFromCoordinates(
        kGooglePlex.target.latitude, kGooglePlex.target.longitude);
    if (result.isNotEmpty) {
      String street;
      String subLocality;
      String locality;
      String administrativeArea;
      String country;

      Placemark placemark = result.first;
      // placemark.
      street = (placemark.street != null) ? placemark.street! + ", " : "";
      subLocality =
          (placemark.subLocality != null) ? placemark.subLocality! + ", " : "";
      locality =
          (placemark.subLocality != null) ? placemark.locality! + ", " : "";
      postalCode =
          (placemark.postalCode != null) ? placemark.postalCode! + ", " : "";
      country = (placemark.country != null) ? placemark.country! : "";
      administrativeArea = (placemark.administrativeArea != null)
          ? "${placemark.administrativeArea!}, "
          : "";
      streetAddressName.value = street;
      fullAddressName.value = street +
          subLocality +
          locality +
          administrativeArea +
          postalCode +
          country;
      isAddressLoading.value = false;
    } else {
      streetAddressName.value = "Tidak ditemukan";
      fullAddressName.value = "Alamat tidak ditemukan";
      isAddressLoading.value = false;
    }
    isAddressLoading.value = false;
  }

  Future<void> getMyLocation() async {
    showLoading();
    var result = await Geolocator.getCurrentPosition();
    LatLng target = LatLng(result.latitude, result.longitude);
    await changeLocation(target);
    searchText.value = "Cari alamat";
    EasyLoading.dismiss();
  }

  Future<void> changeLocation(LatLng target) async {
    controllerMap.moveCamera(
      CameraUpdate.newCameraPosition(
        cameraPositionCustom(target),
      ),
    );
    kGooglePlex = cameraPositionCustom(target);

    // customMarkers.first = customMarkers.first.copyWith(positionParam: target);
    searchAddress();
    update();
  }

  void goToSearch() async {
    var result = await Get.to(
      () => const SearchLocationView(),
      binding: SearchLocationBinding(),
    );
    if (result != null) {
      if (result['prediction'] != null) {
        showLoading();

        AutocompletePrediction prediction = result['prediction'];
        debugPrint("Ini Prediction ${prediction.description}");

        var resultSearchByPlaceId =
            await googlePlace.details.get(prediction.placeId!);
        debugPrint("Masuk sini nih 1");

        if (resultSearchByPlaceId != null &&
            resultSearchByPlaceId.result != null) {
          debugPrint("Masuk sini nih 2");
          searchText.value = prediction.description!;
          LatLng resultCoordinate = LatLng(
              resultSearchByPlaceId.result!.geometry!.location!.lat!,
              resultSearchByPlaceId.result!.geometry!.location!.lng!);
          await changeLocation(resultCoordinate);
          debugPrint("Masuk sini nih 3");
        }
        debugPrint("Masuk sini nih 4");

        EasyLoading.dismiss();
      }
    }
  }

  void save() async {
    if (onMoveCamera.value) {
      searchAddress();
      onMoveCamera.value =false;
    } else {
      Get.back(
        result: ResultLocationInMaps(
          fullAddress: fullAddressName.value,
          posCode: postalCode.replaceAll(RegExp(r','), ""),
          coordinate: kGooglePlex.target,
        ),
      );
    }
  }
}
