import 'package:flutter/material.dart';
import 'package:transaction_client/page/transaction/capital/capital.dart';
import 'package:transaction_client/page/transaction/deal_order/deal_order.dart';
import 'package:transaction_client/page/transaction/entrustment/entrustment.dart';
import 'package:transaction_client/page/transaction/position/position.dart';

class TabItem {
  String name;
  Widget page;

  TabItem({required this.name, required this.page});
}

List<TabItem> initPages = [
  TabItem(name: '挂单', page: const EntrustPage()),
  TabItem(name: '成交单', page: const DealOrderPage()),
  TabItem(name: '持仓', page: const PositionPage()),
  TabItem(name: '资金', page: const CapitalPage()),
];
