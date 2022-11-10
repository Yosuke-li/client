import 'dart:math';

import 'package:flutter/material.dart';
import 'package:native_context_menu/native_context_menu.dart' as native;
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/entrust.dart';
import 'package:transaction_client/page/transaction/entrustment/page/change_order.dart';
import 'package:transaction_client/page/transaction/entrustment/page/delete_order.dart';
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/widget/circle_check_box.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';
import 'package:transaction_client/widget/modal_utils.dart';

import 'entrust_modal.dart';

enum EntrustType {
  all,
  delete,
  canDelete,
  finish,
}

//挂单
class EntrustPage extends StatefulWidget {
  const EntrustPage({Key? key}) : super(key: key);

  @override
  _EntrustState createState() => _EntrustState();
}

class _EntrustState extends State<EntrustPage> {
  List<Entrust> entrusts = [];
  late RightMenuFunc _rightMenuFunc;
  EntrustType type = EntrustType.all;

  @override
  void initState() {
    init();
    super.initState();
    entrusts = [
      Entrust()
        ..id = 0
        ..detail = '123'
        ..settled = '123'
        ..unsettled = '123'
        ..head = '123'
        ..price = '123'
        ..status = '123'
        ..buy = '123'
        ..cell = '123'
        ..open = '123',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
      Entrust()
        ..id = 1
        ..detail = '456'
        ..settled = '456'
        ..unsettled = '456'
        ..head = '456'
        ..price = '456'
        ..status = '456'
        ..buy = '456'
        ..cell = '456'
        ..open = '456',
    ];
  }

  void init() {
    // Log.info('init: ${widget.type}');
    _rightMenuFunc = RightMenuFunc()
      ..onItemSelected = (native.MenuItem item, int index) {
        Log.info('index: $index');
        item.onSelected?.call();
      }
      ..menuItems = [
        native.MenuItem(
          title: '改单',
          onSelected: () async {
            final bool? reBack = await EntrustModal.Modal(context,
                child: ChangeOrder(),
                title: '编辑改单',
                size: ModalSize(width: 445, height: 310));
          },
        ),
        native.MenuItem(
          title: '撤单',
          onSelected: () async {
            final bool? reBack = await EntrustModal.Modal(
              context,
              child: DeleteOrder(),
              title: '操作确认',
              size: ModalSize(width: 400, height: 210),
            );
          },
        ),
        native.MenuItem(
          title: '全撤',
          onSelected: () async {
            final bool? reBack = await EntrustModal.Modal(context,
                child: Container(), title: '操作确认');
          },
        ),
      ];
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant EntrustPage oldWidget) {
    super.didUpdateWidget(oldWidget);
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
                            borderColor: type == EntrustType.all
                                ? const Color(0xcc4285F4)
                                : Theme.of(context).disabledColor,
                            isChecked: type == EntrustType.all,
                            onTap: (bool? value) {
                              type = EntrustType.all;
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
                  Container(
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
                            borderColor: type == EntrustType.canDelete
                                ? const Color(0xcc4285F4)
                                : Theme.of(context).disabledColor,
                            isChecked: type == EntrustType.canDelete,
                            onTap: (bool? value) {
                              type = EntrustType.canDelete;
                              setState(() {});
                            },
                          ),
                        ),
                        const Text('可撤'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
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
                            borderColor: type == EntrustType.finish
                                ? const Color(0xcc4285F4)
                                : Theme.of(context).disabledColor,
                            isChecked: type == EntrustType.finish,
                            onTap: (bool? value) {
                              type = EntrustType.finish;
                              setState(() {});
                            },
                          ),
                        ),
                        const Text('成交'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
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
                            borderColor: type == EntrustType.delete
                                ? const Color(0xcc4285F4)
                                : Theme.of(context).disabledColor,
                            isChecked: type == EntrustType.delete,
                            onTap: (bool? value) {
                              type = EntrustType.delete;
                              setState(() {});
                            },
                          ),
                        ),
                        const Text('已撤'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CommonForm<Entrust>(
                canDrag: true,
                titleColor: Setting.tableBarColor,
                height: 200,
                rightMenuFunc: _rightMenuFunc,
                columns: [
                  FormColumn<Entrust>(
                    title: const Text(
                      '报价编号',
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
                      '买卖',
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
                      '开平',
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
                      '挂单状态',
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
                      '报单价格',
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
                      '报单手数',
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
                      '未成交数',
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
                      '成交手数',
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
                      '详细状态',
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
                        '改单',
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
                      child: const Text('撤单',
                        style: TextStyle(
                          color: Color(0xff333333),
                        ),),
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
                      child: const Text('全撤',
                        style: TextStyle(
                          color: Color(0xff333333),
                        ),),
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

  void getRandom() {
    final Random ran = Random();
    final int first = ran.nextInt(entrusts.length);
    final int second = ran.nextInt(10);
    final int third = ran.nextInt(1000);

    Entrust entrust = entrusts.firstWhere(
      (element) => element.id == first,
    );
    if (entrust != null) {
      final entrustMap = entrust.toJson();
      final key = entrustMap.keys.elementAt(second);
      if (key != 'id') {
        entrustMap.update(key, (value) => third.toString());
        entrust = Entrust.fromJson(entrustMap);
      }
    }
    entrusts.removeWhere((element) => element.id == first);
    entrusts.insert(entrust.id!, entrust);
    setState(() {});
  }
}
