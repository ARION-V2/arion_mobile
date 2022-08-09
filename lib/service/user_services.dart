import 'dart:async';
import 'dart:io';

import 'package:arion/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_return_value.dart';
import '../models/user.dart';

class UserServices extends GetConnect {
  final box = GetStorage();

  Future<ApiReturnValue> register({
    required User user,
    required String password,
  }) async {
    timeout = Duration(seconds: maxResponseTime);
    Response response;
    FormData data = FormData(
      user.toJson(),
    );
    data.fields.addAll([
      MapEntry('password', password),
      MapEntry('password_confirmation', password),
     
    ]);

    String url = urlRegister;
    try {
      response = await post(url, data);
      debugPrint("Data Push = ${data.fields}");
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        return ApiReturnValue(message: response.body['data']['message']);
      }

      var responseData = response.body;
      debugPrint(responseData.toString());
      User.token = responseData['data']['access_token'];

      User result = User.fromJson(responseData['data']);

      return ApiReturnValue(value: result);
    } on TimeoutException catch (_) {
      debugPrint('Time Out Register');
      return const ApiReturnValue(message: 'Time Out, harap mencoba kembali');
    } catch (e) {
      debugPrint('url=$url\n Register User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> login(
      {required String username, required String password}) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;

      var data = FormData({
        'username': username,
        'password': password,
      });

      String url = urlLogin;
      response = await post(
        url,
        data,
      );
      debugPrint("Data Push = ${data.fields}");
      debugPrint("response api = ${response.body}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;
      debugPrint(responseData.toString());
      User.token = responseData['data']['access_token'];

      User result = User.fromJson(responseData['data']['user']);
      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Login User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> getUser() async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;
      User.token = box.read('token');

      String url = urlgetUser;
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

      User result = User.fromJson(responseData['data']);

      return ApiReturnValue(value: result);
    } catch (e) {
      debugPrint('Get User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  // Future<ApiReturnValue> checkNoHp(String noHp) async {
  //   timeout = Duration(seconds: maxResponseTime);

  //   try {
  //     Response response;
  //     User.token = box.read('token');
  //     var data = FormData({
  //       'no_hp': noHp,
  //     });

  //     String url = urlNoHpCheck;
  //     response = await post(
  //       url,
  //       data,
  //       // headers: {
  //       //   "Authorization": "Bearer ${User.token}",
  //       // },
  //     );
  //     debugPrint("response api = " + response.body.toString());
  //     debugPrint("response api 2 = " + response.statusText.toString());
  //     if (response.statusCode != 200) {
  //       String message = (response.body == null)
  //           ? "Terjadi kesalahan"
  //           : response.body['data']['message'];
  //       return ApiReturnValue(message: message);
  //     }
  //     // var responseData = response.body;

  //     return const ApiReturnValue(value: true);
  //   } catch (e) {
  //     debugPrint('Get User Error: ${e.toString()}');
  //     return ApiReturnValue(message: 'Error : ${e.toString()}');
  //   }
  // }

  Future<ApiReturnValue> checkUsername(String username) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;
      User.token = box.read('token');
      var data = FormData({
        'username': username,
      });

      String url = urlUsernameCheck;
      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = ${response.body}");
      debugPrint("response api 2 = ${response.statusText}");
      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['meta']['message'];
        return ApiReturnValue(message: message);
      }
      // var responseData = response.body;

      return const ApiReturnValue(value: true);
    } catch (e) {
      debugPrint('Get User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> logout() async {
    timeout = Duration(seconds: maxResponseTime);

    Response response;

    String url = urlLogout;
    try {
      response = await delete(
        url,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("url=$url\n response api= ${response.body.toString()}");

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }

      return const ApiReturnValue(value: true);
    } catch (e) {
      debugPrint('url=$url\n Logout User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> changePassword(String noHp, String password) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;
      User.token = box.read('token');
      var data = FormData({
        'no_hp': noHp,
        'password': password,
      });

      String url = urlChangePassword;
      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = " + response.body.toString());

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      // var responseData = response.body;

      return const ApiReturnValue(value: true);
    } catch (e) {
      debugPrint('Get User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> updateProfile(User user) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;
      User.token = box.read('token');
      var data = FormData(user.toJson());

      String url = urlUpdateProfile;
      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = " + response.body.toString());

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      User userResult = User.fromJson(responseData['data']);
      debugPrint("After Update");
      debugPrint(userResult.toString());

      return  ApiReturnValue(value: userResult);
    } catch (e) {
      debugPrint('Update User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }

  Future<ApiReturnValue> updatePhotoProfile(File file) async {
    timeout = Duration(seconds: maxResponseTime);

    try {
      Response response;
      User.token = box.read('token');
      var data =  FormData({
        'file': MultipartFile(
          File(file.path),
          filename: file.path.isNotEmpty ? file.path.split('/').last : '...',
        ),
      });

      String url = urlUpdatePhotoProfile;
      response = await post(
        url,
        data,
        headers: {
          "Authorization": "Bearer ${User.token}",
        },
      );
      debugPrint("response api = " + response.body.toString());

      if (response.statusCode != 200) {
        String message = (response.body == null)
            ? "Terjadi kesalahan"
            : response.body['data']['message'];
        return ApiReturnValue(message: message);
      }
      var responseData = response.body;

      User userResult = User.fromJson(responseData['data']);
      debugPrint("After Update");
      debugPrint(userResult.toString());

      return  ApiReturnValue(value: userResult);
    } catch (e) {
      debugPrint('Update User Error: ${e.toString()}');
      return ApiReturnValue(message: 'Error : ${e.toString()}');
    }
  }
}
