import 'package:arion/models/partner.dart';
import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../utils/api_return_value.dart';

class PartnerServices extends GetConnect {
  Future<ApiReturnValue> getPartners() async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = urlgetAllPartner;
      response = await get(
        url,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      List<Partner> result = (responseData['data'] as Iterable)
          .map(
            (e) => Partner.fromJson(e),
          )
          .toList();

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get Partner Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> addUpdatePartners(Partner partner) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = urlAddPartner;
      var data = FormData(partner.toJson());

      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      Partner result = Partner.fromJson(responseData['data']);

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('ADD/UPDATE Partner Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> deletePartners(Partner partner) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = "$urlDeletePartner?id=${partner.id}";

      response = await delete(
        url,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;


      return ApiReturnValue(value: true);
    } catch (e) {
      debugPrint('Delete Partner Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
