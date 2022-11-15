import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/entrust.dart';
import 'package:transaction_client/page/transaction/entrustment/test_data.dart';
import 'package:transaction_client/widget/circle_check_box.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

enum PositionType {
  all,
  today,
}

enum PositionMerge {
  variety,
  contract,
}

class PositionPage extends StatefulWidget {
  const PositionPage({Key? key}) : super(key: key);

  @override
  State<PositionPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> with AutomaticKeepAliveClientMixin {
  PositionType type = PositionType.all;
  List<PositionMerge> merges = [];
  List<Entrust> entrusts = [];

  @override
  void initState() {
    super.initState();
    entrusts = testData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 3),
                              child: CircleCheckBox(
                                size: 15,
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                checkedWidget: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                checkedColor: const Color(0xcc4285F4),
                                borderColor: type == PositionType.all
                                    ? const Color(0xcc4285F4)
                                    : Theme.of(context).disabledColor,
                                isChecked: type == PositionType.all,
                                onTap: (bool? value) {
                                  type = PositionType.all;
                                  setState(() {});
                                },
                              ),
                            ),
                            const Text('全部'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: CircleCheckBox(
                              size: 15,
                              animationDuration:
                                  const Duration(milliseconds: 100),
                              checkedWidget: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                              checkedColor: const Color(0xcc4285F4),
                              borderColor: type == PositionType.today
                                  ? const Color(0xcc4285F4)
                                  : Theme.of(context).disabledColor,
                              isChecked: type == PositionType.today,
                              onTap: (bool? value) {
                                type = PositionType.today;
                                setState(() {});
                              },
                            ),
                          ),
                          const Text('今日'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 3),
                              child: Transform.scale(
                                scale: 0.8,
                                child: Checkbox(
                                  value: merges.contains(PositionMerge.variety),
                                  onChanged: (bool? value) {
                                    if (merges
                                        .contains(PositionMerge.variety)) {
                                      merges.removeWhere((element) =>
                                          element == PositionMerge.variety);
                                    } else {
                                      merges.add(PositionMerge.variety);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            const Text('品种合并'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                value: merges.contains(PositionMerge.contract),
                                onChanged: (bool? value) {
                                  if (merges.contains(PositionMerge.contract)) {
                                    merges.removeWhere((element) =>
                                        element == PositionMerge.contract);
                                  } else {
                                    merges.add(PositionMerge.contract);
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          const Text('合约合并'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: CommonForm<Entrust>(
                canDrag: true,
                titleColor: Setting.tableBarColor,
                height: 200,
                columns: [
                  FormColumn<Entrust>(
                    title: const Text(
                      '品种',
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
                      '多头持仓',
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
                      '空头持仓',
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
                      '净持仓',
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
                      '今日开仓',
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
                      '开仓均价',
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
                      '浮动盈亏',
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
                      '盯市盈亏',
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
                      '盈亏比例',
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
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Setting.bottomBorderColor),
                ),
              ),
              padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15),
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
                        '平仓',
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
