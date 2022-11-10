import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSubmitState {
  late GlobalKey<FormState> formKey;
  // late OrderSubmit create;

  late RxBool isShowBar;

  late RxInt side;
  late RxInt tif;
  late RxInt ordType;
  late RxInt openFlag;
  late RxInt hedgeFlag;

  late RxBool readOnly;

  late List<int> sides;
  late List<int> tifs;
  late List<int> ordTypes;
  late List<int> openFlags;
  late List<int> hedgeFlags;

  late FocusNode focusNode;

  OrderSubmitState() {
    formKey = GlobalKey<FormState>();
    // create = OrderSubmit();
    sides = <int>[];
    tifs = <int>[];
    ordTypes = <int>[];
    openFlags = <int>[];
    hedgeFlags = <int>[];
    isShowBar = true.obs;
    readOnly = false.obs;
    side = 0.obs;
    tif = 0.obs;
    ordType = 0.obs;
    openFlag = 0.obs;
    hedgeFlag = 0.obs;
    focusNode = FocusNode();
  }
}
