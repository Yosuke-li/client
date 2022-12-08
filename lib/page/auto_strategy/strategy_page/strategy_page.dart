import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/entrust.dart';
import 'package:transaction_client/page/transaction/entrustment/test_data.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

class StrategyPage extends StatefulWidget {
  const StrategyPage({Key? key}) : super(key: key);

  @override
  State<StrategyPage> createState() => _StrategyPageState();
}

class _StrategyPageState extends State<StrategyPage> {
  List<Entrust> entrusts = [];
  // late RightMenuFunc _rightMenuFunc;

  @override
  void initState() {
    super.initState();
    entrusts = testData;
    setState(() {});
  }

  void init() {

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CommonForm<Entrust, dynamic>(
            canDrag: true,
            titleColor: Setting.tableBarColor,
            height: 200,
            columns: [
              FormColumn<Entrust>(
                title: const Text(
                  '序号',
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
                  '策略名称',
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
                  '下单合约1',
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
                  '合约1手数',
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
                  '下单合约2',
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
                  '合约2手数',
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
                  '执行条件',
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
                  '状态',
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
            ],
            values: entrusts,
          ),
        ),
        Container(
          height: Setting.tableBottomHeight,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Setting.bottomBorderColor),
            ),
          ),
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Setting.backGroundColor)),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    '启动策略',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Setting.backGroundColor)),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    '暂停',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Setting.backGroundColor)),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    '删除策略',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
