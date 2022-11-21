import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSubmitState {
  late GlobalKey<FormState> formKey;
  // late OrderSubmit create;

  late RxBool isShowBar;

  late RxString side;
  late RxString tif;
  late RxString orderType;
  late RxString positionType;
  late RxString insuredType;

  late RxBool readOnly;

  late List<String> sides;
  late List<String> tifs;
  late List<String> orderTypes;
  late List<String> positionTypes;
  late List<String> insuredTypes;

  late FocusNode focusNode;

  OrderSubmitState() {
    formKey = GlobalKey<FormState>();
    // create = OrderSubmit();
    sides = <String>[];
    tifs = <String>[];
    orderTypes = <String>[];
    positionTypes = <String>[];
    insuredTypes = <String>[];
    isShowBar = true.obs;
    readOnly = false.obs;
    side = ''.obs;
    tif = ''.obs;
    orderType = ''.obs;
    insuredType = ''.obs;
    positionType = ''.obs;
    focusNode = FocusNode();
  }
}
