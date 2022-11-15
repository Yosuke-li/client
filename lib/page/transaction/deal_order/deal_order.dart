import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/entrust.dart';
import 'package:transaction_client/page/transaction/entrustment/test_data.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

class DealOrderPage extends StatefulWidget {
  const DealOrderPage({Key? key}) : super(key: key);

  @override
  State<DealOrderPage> createState() => _DealOrderPageState();
}

class _DealOrderPageState extends State<DealOrderPage> {
  List<Entrust> entrusts = [];

  @override
  void initState() {
    super.initState();
    entrusts = testData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonForm<Entrust>(
        canDrag: true,
        titleColor: Setting.tableBarColor,
        height: 200,
        columns: [
          FormColumn<Entrust>(
            title: const Text(
              '时间',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.id ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '合约',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.cell ?? ''}',
                style: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '方向',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.buy ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '开平标志',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.open ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '成交量',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                v.status ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '成交价',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.price ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '手续费',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.head ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '平仓盈亏',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.unsettled ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '成交单号',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.settled ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          FormColumn<Entrust>(
            title: const Text(
              '挂单号',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
            builder: (_, v) => Container(
              child: Text(
                '${v.detail ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
        values: entrusts,
      ),
    );
  }
}
