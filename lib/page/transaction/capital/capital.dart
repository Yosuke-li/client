import 'package:flutter/material.dart';
import 'package:transaction_client/utils/array_helper.dart';

class CapitalPage extends StatefulWidget {
  const CapitalPage({Key? key}) : super(key: key);

  @override
  State<CapitalPage> createState() => _CapitalPageState();
}

class _CapitalPageState extends State<CapitalPage> {
  static const List<String> _data = <String>[
    '期初现金',
    '当前权益',
    '质押资金',
    '可质押金额',
    '出入金',
    '权利金',
    '手续费',
    '可用资金',
    '现金',
  ];
  static const List<String> _data2 = [
    '币种',
    '期权市值',
    '市值权益',
    '保证金',
    '挂单保证金',
    '挂单手续费',
    '资金风险率',
    '平仓盈亏',
    '浮动盈亏'
  ];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 150, top: 10),
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Table(
                border: const TableBorder(
                  top: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  left: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  right: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  horizontalInside: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  verticalInside: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                children: _data
                    .map(
                      (e) => TableRow(children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: Text(e),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: const Text('1'),
                        ),
                      ]),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Table(
                border: const TableBorder(
                  top: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  left: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  right: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  horizontalInside: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                  verticalInside: BorderSide(
                      color: Color(0x50333333),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                children: _data2
                    .map(
                      (e) => TableRow(children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: Text(e),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: const Text('1'),
                        ),
                      ]),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
