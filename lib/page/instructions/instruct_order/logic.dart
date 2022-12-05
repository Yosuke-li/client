import 'package:get/get.dart';

import 'package:transaction_client/global/order_json.dart';
import 'package:transaction_client/model/order_risk_control.dart';
import 'package:transaction_client/page/instructions/instruct_utils/eventbus.dart';
import 'package:transaction_client/utils/event_bus_helper.dart';

import 'state.dart';

class InstructOrderLogic extends GetxController {
  final InstructOrderState state = InstructOrderState();

  @override
  void onReady() {
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
    EventBusHelper.listen<InstructEventBus>((event) {
      /// 合约组传数据

    });
  }
}
