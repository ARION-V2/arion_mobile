import 'package:arion/models/partner.dart';
import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/direction.dart';
import '../models/user.dart';
import '../utils/api_return_value.dart';

class DirecticonServices extends GetConnect {
  Future<ApiReturnValue> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;
      debugPrint("Masuk API 1");
      String url = "https://maps.googleapis.com/maps/api/directions/json?";
      response = await get(url, query: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': googleMapsKey,
      });
      debugPrint("Masuk API 2");

      debugPrint("response api Direction= ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      debugPrint("Masuk API 3");

      return ApiReturnValue(value: Directions.fromMap(response.body));
    } catch (e) {
      debugPrint("Masuk API 4");

      debugPrint('Get Direction Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
