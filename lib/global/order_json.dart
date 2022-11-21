import 'package:transaction_client/model/order_risk_control.dart';

class OrderJson {
  /// 大连:DCE 郑州:CZCE 上海:SHFE 上海能源:INE 中金:CFFE
  /// TIF: DAY当天有效，FOK全部成交，FAK立即成交和撤销
  static List<OrderRiskControl> riskControls = [
    OrderRiskControl(
      '大连商品交易所',
      'DCE',
      ['套保', '投机', '套利'],
      ['limit', 'Market', 'Stop'],
      ['开仓', '平仓', '平今'],
      ['DAY', 'FOK', 'FAK'],
    ),
    OrderRiskControl(
      '郑州商品交易所',
      'CZCE',
      ['套保', '投机', '套利'],
      ['limit', 'Market'],
      ['开仓', '平仓', '平今'],
      ['DAY', 'FAK'],
    ),
    OrderRiskControl(
      '上海国际能源交易中心',
      'INE',
      ['套保', '投机'],
      ['limit'],
      ['开仓', '平仓', '平今'],
      ['DAY', 'FAK', 'FOK'],
    ),
    OrderRiskControl(
      '中金所',
      'CFFE',
      ['套保', '投机'],
      ['limit'],
      ['开仓', '平仓', '平今'],
      ['DAY', 'FAK', 'FOK'],
    ),
    OrderRiskControl(
      '上海期货交易所',
      'SHFE',
      ['套保', '投机'],
      ['limit'],
      ['开仓', '平仓', '平今'],
      ['DAY'],
    ),
  ];
}
