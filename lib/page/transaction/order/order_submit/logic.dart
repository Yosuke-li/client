import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_client/global/global.dart';
import 'package:transaction_client/global/order_json.dart';
import 'package:transaction_client/model/order_risk_control.dart';
import 'package:transaction_client/utils/dio/dio_helper.dart';
import 'package:transaction_client/utils/event_bus_helper.dart';
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/widget/toast_utils.dart';

import 'state.dart';

class OrderSubmitLogic extends GetxController {
  final state = OrderSubmitState();

  @override
  void onReady() {
    if (Platform.isWindows || Platform.isMacOS) {
      state.isShowBar.value = false;
    }
    _init();
    _eventBusListen();
    super.onReady();
  }

  void _init({String? cnKey, String? enKey}) {
    state.sides.value = ['买', '卖'];
    late OrderRiskControl control;
    if (cnKey == null && enKey == null) {
      control = OrderJson.riskControls.first;
    } else {
      control = OrderJson.riskControls.firstWhere(
        (element) => element.cnName == cnKey || element.enName == enKey,
      );
    }
    state.tifs.value = control.tif;
    state.orderTypes.value = control.orderType;
    state.positionTypes.value = control.positionType;
    state.insuredTypes.value = control.insuredType;
    state.side.value = state.sides[0];
    state.tif.value = state.tifs[0];
    state.insuredType.value = state.insuredTypes[0];
    state.orderType.value = state.orderTypes[0];
    state.positionType.value = state.positionTypes[0];
  }

  void _eventBusListen() {
    EventBusHelper.listen<EventSelect>((event) {
      if (event.value != null) {
        if (Global.lock == true) {
          ToastUtils.showToast(msg: '合约已锁定，需要修改请点击图标解锁');
        } else {
          _init(enKey: event.value.password);
          state.controller.text = event.value.username;
        }
      }
    });
  }

  //提交
  void onSubmit() async {
    _init(cnKey: '中金所');
    final FormState? from = state.formKey.currentState;
    from!.save();
    if (from.validate()) {
      try {
        // final res = await Request.post(ApiCenter.order, data: {
        //   'username': Global.user?.username,
        //   'price': state.create.price,
        //   'ordQty': state.create.ordQty,
        //   'rawSide': state.side.value,
        //   'rawOrdType': state.ordType.value,
        //   'rawTif': state.tif.value,
        //   'refId': state.create.refId,
        //   'account': state.create.account,
        //   'rawOpenFlag': state.openFlag.value,
        //   'rawHedgeFlag': state.hedgeFlag.value,
        // });
        // Log.info(res);
        // ToastUtils.showToast(msg: '${res.data}');
      } catch (error, stack) {
        Log.error(error, stackTrace: stack);
        rethrow;
      }
    }
  }
}
