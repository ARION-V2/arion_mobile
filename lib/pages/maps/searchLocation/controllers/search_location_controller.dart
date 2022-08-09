import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

import '../../../../../shared/shared.dart';
import '../../../../shared/variable_const.dart';

class SearchLocationController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final count = 0.obs;
  var predictions = List<AutocompletePrediction>.empty().obs;
  var searchText = "".obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  Future<void> searchAddress() async {
    if (searchController.text.trim() != "") {
      var result = await googlePlace.autocomplete.get(
        searchController.text,
        language: 'id',
        region: 'id',
      );
      if (result != null) {
        predictions.value =
            (result.predictions!.isEmpty) ? [] : result.predictions!;
      } else {
        predictions.value = [];
      }
    } else {
      predictions.value = [];
    }
  }
}
