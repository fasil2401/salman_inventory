import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/model/login_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    prefilData();
  }

  var response = 0.obs;
  var isLoading = false.obs;
  var isAttaching = false.obs;
  var res = 0.obs;
  var message = ''.obs;
  var token = ''.obs;
  var userId = ''.obs;
  var connectionName = ''.obs;
  var dbName = ''.obs;
  var password = TextEditingController().obs;
  var userName = TextEditingController().obs;
  var serverIp = ''.obs;
  var port = ''.obs;
  var database = ''.obs;
  var isRemember = false.obs;
  var status = true.obs;
  var icon = AppIcons.eye_close.obs;
  var nameWarning = false.obs;
  var passwordWarning = false.obs;

  prefilData() async {
    final bool isRemembered =
        UserSimplePreferences.getRememberPassword() ?? false;
    userName.value.text = await UserSimplePreferences.getUsername() ?? '';
    password.value.text =
        isRemembered ? await UserSimplePreferences.getUserPassword() ?? '' : '';
  }

  rememberPassword() async {
    isRemember.value = !isRemember.value;
  }

  check() {
    if (status.value == true) {
      status.value = false;
      icon.value = AppIcons.eye_open;
    } else {
      status.value = true;
      icon.value = AppIcons.eye_close;
    }
  }

  validateForm() {
    if (userName.value.text.isEmpty) {
      nameWarning.value = true;
    } else {
      nameWarning.value = false;
      UserSimplePreferences.setUsername(userName.value.text);
    }
    if (password.value.text.isEmpty) {
      passwordWarning.value = true;
    } else {
      passwordWarning.value = false;
      UserSimplePreferences.setUserPassword(password.value.text);
    }
  }

  getToken() async {
    isLoading.value = true;
    final String database = UserSimplePreferences.getDatabase() ?? '';
    final String port = UserSimplePreferences.getPort() ?? '';
    final String serverIp = UserSimplePreferences.getServerIp() ?? '';
    final String userId = UserSimplePreferences.getUsername() ?? '';
    final String password = UserSimplePreferences.getUserPassword() ?? '';
    print('port is $port');
    final data = jsonEncode({
      "Instance": serverIp,
      "UserId": userId,
      "Password": password,
      "PasswordHash": "",
      "DbName": database,
      "Port": port,
      "servername": ""
    });
    print(data);
    dynamic result;

    try {
      var feedback =
          await ApiManager.fetchDataRawBody(api: 'Gettoken', data: data);
          
      if (feedback != null) {
        result = LoginModel.fromJson(feedback);
        response.value = result.res;
        message.value = result.msg;
        if (response.value == 1) {
          token.value = result.loginToken;
          this.userId.value = result.userId;
          print(token.value);
          return true;
        } else {
         
          print('error');
          return false;
        }
      }

    } finally {
       isLoading.value = false;
      
    }
  }
}
