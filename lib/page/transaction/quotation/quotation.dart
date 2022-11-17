import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:native_context_menu/native_context_menu.dart' as native;
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/account.dart';
import 'package:transaction_client/page/transaction/quotation/setting.dart';
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

class QuotationPage extends StatefulWidget {
  final double? height;

  const QuotationPage({Key? key, this.height}) : super(key: key);

  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<QuotationPage> {
  List<Account> users = [
    Account()
      ..username = '1'
      ..password = '564',
    Account()
      ..username = '2'
      ..password = '564',
    Account()
      ..username = '3'
      ..password = '4',
    Account()
      ..username = '5'
      ..password = '564',
  ];

  List<String> groups = ['123', '456'];
  String select_group = '123';
  late RightMenuFunc _rightMenuFunc;
  bool canDrag = true;

  @override
  void initState() {
    _init(); // late要在初始化之前
    super.initState();
  }

  //右键菜单栏
  void _init() {
    _rightMenuFunc = RightMenuFunc()
      ..onItemSelected = (native.MenuItem item, int index) {
        Log.info('index: $index');
        item.onSelected?.call();
      }
      ..menuItems = [
        native.MenuItem(title: '下单'),
        native.MenuItem(
            title: '移动到',
            items: [native.MenuItem(title: '1'), native.MenuItem(title: '2')]),
        native.MenuItem(
            title: '设置合约',
            onSelected: () {
              QuoSetting.Modal(context);
            }),
        native.MenuItem(title: '删除'),
      ];
    setState(() {});
  }

  void _onSetTapUp(TapUpDetails e) async {
    final position = Offset(
      e.globalPosition.dx + Offset.zero.dx,
      e.globalPosition.dy + Offset.zero.dy,
    );

    final selectedItem = await native.showContextMenu(
      native.ShowMenuArgs(
        MediaQuery.of(context).devicePixelRatio,
        position,
        [
          native.MenuItem(title: '添加合约'),
          native.MenuItem(
            title: '标记排序',
            onSelected: () {
              canDrag = !canDrag;
              setState(() {});
            },
          ),
        ],
      ),
    );

    if (selectedItem != null) {
      selectedItem.onSelected?.call();
    }
  }

  /// todo 点击将合约和现价发到下单页面
  void _eventBus() {}

  /// max height*0.6
  /// min height*0.04
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        alignment: Alignment.centerLeft,
        child: ListView(
          children: [
            //拖拽
            Container(
              color: Setting.backGroundColor,
              height: 28,
              child: Row(
                children: [
                  Row(
                    children: groups
                        .map(
                          (e) => Draggable<String>(
                            data: e,
                            feedback: Container(
                              width: 80,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, style: BorderStyle.solid),
                              ),
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            child: DragTarget<String>(
                              onAccept: (o) {
                                int from = groups.indexOf(o);
                                int to = groups.indexOf(e);
                                final temp = groups[from];
                                groups[from] = groups[to];
                                groups[to] = temp;
                                setState(() {});
                              },
                              builder: (context, _, __) {
                                return InkWell(
                                  onTap: () {
                                    select_group = e;
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: select_group == e
                                          ? Setting.tabSelectColor
                                          : null,
                                    ),
                                    child: Text(e, textAlign: TextAlign.center),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  InkWell(
                    onTap: () {
                      QuoSetting.addGroups(context);
                    },
                    child: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            CommonForm<Account>(
              canDrag: canDrag,
              onTapFunc: (Account value) {
                Log.info(value.username!);
              },
              showExtra: true,
              rightMenuFunc: _rightMenuFunc,
              titleColor: Setting.tableBarColor,
              columns: [
                FormColumn<Account>(
                  title: const Text(
                    '编号',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  width: 50,
                  extraBuilder: GestureDetector(
                    onTap: () {
                      QuoSetting.Modal(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add_box_outlined,
                        size: 18,
                        color: Color(0x50000000),
                      ),
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${users.indexOf(v)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Setting.tableBlue,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
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
                      v.username ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: Setting.tableBlue,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '合约名',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.username ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Setting.tableBlue,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '最新价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Setting.tableRed,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '涨幅',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Setting.tableRed,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '涨跌',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Setting.tableRed,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '买价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '卖价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '买量',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '卖量',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
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
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '持仓量',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '现量',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '涨停价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '涨跌价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '今开盘',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '昨收盘',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '最高价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '最低价',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '成交额',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '交易所',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                FormColumn<Account>(
                  title: const Text(
                    '行情更新时间',
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  builder: (_, v) => Container(
                    child: Text(
                      '${v.password ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
              values: users,
            ),
          ],
        ),
      ),
    );
  }
}
