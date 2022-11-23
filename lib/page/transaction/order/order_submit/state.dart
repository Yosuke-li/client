import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSubmitState {
  late GlobalKey<FormState> formKey;
  // late OrderSubmit create;

  late RxBool isShowBar;

  late TextEditingController controller;
  late TextEditingController hands;
  late TextEditingController price;
  late RxString side;
  late RxString tif;
  late RxString orderType;
  late RxString positionType;
  late RxString insuredType;

  late RxList<String> sides;
  late RxList<String> tifs;
  late RxList<String> orderTypes;
  late RxList<String> positionTypes;
  late RxList<String> insuredTypes;

  late FocusNode focusNode;

  OrderSubmitState() {
    formKey = GlobalKey<FormState>();
    // create = OrderSubmit();
    controller = TextEditingController();
    hands = TextEditingController();
    price = TextEditingController();
    sides = <String>[].obs;
    tifs = <String>[].obs;
    orderTypes = <String>[].obs;
    positionTypes = <String>[].obs;
    insuredTypes = <String>[].obs;
    isShowBar = true.obs;
    side = ''.obs;
    tif = ''.obs;
    orderType = ''.obs;
    insuredType = ''.obs;
    positionType = ''.obs;
    focusNode = FocusNode();
  }
}
