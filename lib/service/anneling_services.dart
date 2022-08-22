import 'package:arion/models/Tsp_anneling.dart';
import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';

import '../utils/api_return_value.dart';

class AnnelingServices extends GetConnect {
  Future<ApiReturnValue> runAnneling({
    required String nameGundang, 
    required List<String> destinations,
  }) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = '$basePython/cacluate-tsp';
      var data = {
        'start_location': nameGundang,
        "destination_locations": destinations,
        "method": "annealing"
      };
      response = await post(url, data);
      debugPrint("response Anneling api  = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      TspAnnaling result = TspAnnaling.fromJson(responseData);

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get Anneling Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
