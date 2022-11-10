import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/account.dart';
import 'package:transaction_client/page/management/home_page.dart';
import 'package:transaction_client/utils/lock.dart';
import 'package:transaction_client/utils/navigator.dart';
import 'package:transaction_client/utils/store.dart';
import 'package:transaction_client/widget/toast_utils.dart';
import 'package:window_manager/window_manager.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    LocateStorage.init().whenComplete(() => getAccount());
    super.onInit();
  }

  void getAccount() {
    String? result = LocateStorage.getString('Account');
    if (result != null) {
      Account account = Account.fromJson(jsonDecode(result));
      state.nameController.text = account.username ?? '';
      state.passController.text = account.password ?? '';
      state.isSave.value = account.isSave ?? false;
    }
  }

  void login() async {
    Lock lock = Lock();
    final FormState? from = state.formKey.currentState;
    from!.save();
    if (from.validate()) {
      bool c = _check();
      if (c == true) {
        await lock.lock();
        try {
          await Setting.normalSize();
          setAccount();
          Get.off(() => const HomePage());
          lock.unlock();
        } catch (err) {
          rethrow;
        }
      }
    }
  }

  void setAccount() {
    Account account = Account()
      ..isSave = state.isSave.value
      ..username = state.nameController.text
      ..password = state.passController.text;
    LocateStorage.setString('Account', json.encode(account));
  }

  bool _check() {
    String? errText;
    if (state.passController.text.isEmpty == true) {
      errText = '密码不能为空';
    }
    if (state.nameController.text.isEmpty == true) {
      errText = '账户不能为空';
    }

    if (errText != null) {
      ToastUtils.showToast(msg: errText);
      return false;
    }

    return true;
  }

  void closeWindowsManager() async {
    await windowManager.close();
  }

  void change() {
    state.isSave.value = !state.isSave.value;
  }
}
