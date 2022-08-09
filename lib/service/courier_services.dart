import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../utils/api_return_value.dart';

class CourierServices extends GetConnect {
  Future<ApiReturnValue> getCourier() async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = urlGetAllCourier;
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

      List<User> result = (responseData['data'] as Iterable)
          .map(
            (e) => User.fromJson(e),
          )
          .toList();

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get Courier Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> addOrUpdate({
    required User user,
    String? password,
    File? photo,
  }) async {
    timeout = Duration(seconds: maxResponseTime);
    Response response;
    FormData data = FormData(
      user.toJson(),
    );
    if (password != null) {
      data.fields.addAll([
        MapEntry('password', password),
      ]);
    }
    if (photo != null) {
      data.files.add(
        MapEntry(
          'file',
          MultipartFile(
            photo.path,
            filename:
                photo.path.isNotEmpty ? photo.path.split('/').last : '...',
          ),
        ),
      );
    }

    String url = urlUpdateCourier;
    try {
      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("Data Push = ${data.fields}");
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        return ApiReturnValue(message: response.body['data']['message']);
      }

      var responseData = response.body;
      debugPrint(responseData.toString());

      User result = User.fromJson(responseData['data']);

      return ApiReturnValue(value: result);
    } on TimeoutException catch (_) {
      debugPrint('Time Out Courier');
      return const ApiReturnValue(message: 'Time Out, harap mencoba kembali');
    } catch (e) {
      debugPrint('url=$url\n Register Courier Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> deleteCourier(User courier) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = "$urlDeleteCourier?id=${courier.id}";

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
      return const ApiReturnValue(value: true);
    } catch (e) {
      debugPrint('Delete Partner Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
