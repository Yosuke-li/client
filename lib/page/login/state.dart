import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginState {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController passController;
  late RxBool isSave;

  LoginState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    passController = TextEditingController();
    isSave = false.obs;
  }
}
