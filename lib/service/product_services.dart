import 'dart:async';
import 'dart:io';

import 'package:arion/models/product.dart';
import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../utils/api_return_value.dart';

class ProductServices extends GetConnect {
  Future<ApiReturnValue> getProduct() async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = urlGetAllProduct;
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

      List<Product> result = (responseData['data'] as Iterable)
          .map(
            (e) => Product.fromJson(e),
          )
          .toList();

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get Product Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> addOrUpdate({
    required Product product,
    File? photo,
  }) async {
    timeout = Duration(seconds: maxResponseTime);
    Response response;
    FormData data = FormData(
      product.toJson(),
    );
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

    String url = urlUpdateProduct;
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

      Product result = Product.fromJson(responseData['data']);

      return ApiReturnValue(value: result);
    } on TimeoutException catch (_) {
      debugPrint('Time Out Courier');
      return const ApiReturnValue(message: 'Time Out, harap mencoba kembali');
    } catch (e) {
      debugPrint('url=$url\n Add/Update Product Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> deleteProduct(Product product) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      String url = "$urlDeleteProduct?id=${product.id}";

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
      debugPrint('Delete Product Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
