import 'dart:io';

import 'package:arion/models/delivery.dart';
import 'package:arion/models/mapping_delivery.dart';
import 'package:arion/models/partner.dart';
import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../utils/api_return_value.dart';

class DeliveryServices extends GetConnect {
  Future<ApiReturnValue> getDelivery({
    String? status,
    bool isNotDone =false,
  }) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = "$urlGetAllDelivery${(status!=null)?'?status=$status':''}${(isNotDone)?'?isNotDone=1':''}";
      response = await get(
        url,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("Request api = ${url}");
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      List<Delivery> result = (responseData['data'] as Iterable)
          .map(
            (e) => Delivery.fromJson(e),
          )
          .toList();

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get Partner Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }


  Future<ApiReturnValue> mappingDelivery() async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = urlGetMappingDelivery;
      response = await get(
        url,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("Request api = ${url}");
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      List<MappingDelivery> result = (responseData['data'] as Iterable)
          .map(
            (e) => MappingDelivery.fromJson(e),
          )
          .toList();

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get MappingDelivery Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> addUpdateDelivery(
      {required Delivery delivery, File? photoFile}) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = urlUpdateDelivery;

      var data = FormData(delivery.toJson());

      if (photoFile != null) {
        data.files.add(
          MapEntry(
            'file',
            MultipartFile(
              photoFile.path,
              filename: photoFile.path.isNotEmpty
                  ? photoFile.path.split('/').last
                  : '...',
            ),
          ),
        );
      }

      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("request data = ${data.fields}");

      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      Delivery result = Delivery.fromJson(responseData['data']);

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('ADD/UPDATE Delivery Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> deleteDelivery(Delivery delivery) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = "$urlDeleteDelivery?id=${delivery.id}";

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

      return ApiReturnValue(value: true);
    } catch (e) {
      debugPrint('Delete Delivery Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
