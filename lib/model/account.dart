import 'package:transaction_client/model/entrust.dart';

class Account {
  String? username;
  String? password;
  bool? isRead;
  bool? isSave;
  String? accessToken;
  String? refreshToken;
  //todo
  List<Entrust>? entrusts;

  Account({
    String? username,
    String? password,
    String? refreshToken,
    bool? isRead,
    bool? isSave,
    String? accessToken, List<Entrust>? entrusts}){
    username = username;
    password = password;
    isRead = isRead;
    isSave = isSave;
    accessToken = accessToken;
    refreshToken = refreshToken;
    entrusts=entrusts;
  }

  Account.fromJson(dynamic json) {
    username = json["username"];
    password = json["password"];
    isRead = json["isRead"];
    isSave = json["isSave"];
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["username"] = username;
    map["password"] = password;
    map["isRead"] = isRead;
    map["isSave"] = isSave;
    map["accessToken"] = accessToken;
    map["refreshToken"] = refreshToken;
    return map;
  }
}