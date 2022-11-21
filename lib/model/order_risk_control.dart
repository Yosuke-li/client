
class OrderRiskControl {
  String cnName;
  String enName;

  /// 交易单类型
  List<String> orderType;

  /// tif
  List<String> tif;

  /// 开平
  List<String> positionType;

  /// 投保类型
  List<String> insuredType;

  OrderRiskControl(this.cnName, this.enName, this.insuredType, this.orderType,
      this.positionType, this.tif);

  factory OrderRiskControl.fromJson(dynamic json) => OrderRiskControl(
      json['cnName'] as String,
      json['enName'] as String,
      json['insuredType'] as List<String>,
      json['orderType'] as List<String>,
      json['positionType'] as List<String>,
      json['tif'] as List<String>);

  dynamic toJson() => <String, dynamic>{
        'cnName': cnName,
        'enName': enName,
        'insuredType': insuredType,
        'orderType': orderType,
        'positionType': positionType,
        'tif': tif,
      };

  static List<OrderRiskControl> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((e) => OrderRiskControl.fromJson(e)).toList();
  }
}
