import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:native_context_menu/native_context_menu.dart' as native;
import 'package:transaction_client/global/global.dart';
import 'package:transaction_client/global/order_json.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/account.dart';
import 'package:transaction_client/page/transaction/quotation/setting.dart';
import 'package:transaction_client/utils/event_bus_helper.dart';
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';
import 'package:transaction_client/widget/toast_utils.dart';

class QuotationPage extends StatefulWidget {
  final double? height;

  const QuotationPage({Key? key, this.height}) : super(key: key);

  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<QuotationPage> {
  List<Account> users = [
    Account()
      ..username = 'CU202203'
      ..password = 'DCE',
    Account()
      ..username = 'ZH202203'
      ..password = 'CZCE',
    Account()
      ..username = 'ZH202206'
      ..password = 'INE',
  ];

  late RightMenuFunc _rightMenuFunc;
  bool canDrag = true;

  @override
  void initState() {
    _init(); // late要在初始化之前
    super.initState();
  }

  @override
  void didUpdateWidget(covariant QuotationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.height != oldWidget.height) {
      setState(() {});
    }
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

  void _eventBus(dynamic value) {
    if (Global.lock != true) {
      EventBusHelper.asyncStreamController?.add(EventSelect()..value = value);
    } else {
      ToastUtils.showToast(msg: '合约已锁定，需要修改请点击合约锁图标解锁');
    }
  }

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
            const _TopGroups(),
            CommonForm<Account>(
              canDrag: canDrag,
              onTapFunc: (Account value) {
                _eventBus(value);
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
                    '品种',
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
                    '合约编码',
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
                    '现价',
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
                    '振幅',
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
                    '开盘价',
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
                    '昨日收盘价',
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
                    '昨日结算价',
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

class _TopGroups extends StatefulWidget {
  const _TopGroups({Key? key}) : super(key: key);

  @override
  State<_TopGroups> createState() => _TopGroupsState();
}

class _TopGroupsState extends State<_TopGroups> {
  List<String> groups = ['123', '456'];
  String selectGroup = '123';

  bool shouldReact = false;
  late RightMenuFunc _rightMenuFunc;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _rightMenuFunc = RightMenuFunc()
      ..onItemSelected = (native.MenuItem item, int index) {
        Log.info('index: $index');
        item.onSelected?.call();
      }
      ..menuItems = [
        native.MenuItem(title: '重命名', onSelected: () {}),
        native.MenuItem(title: '删除', onSelected: () {}),
      ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        border:
                            Border.all(width: 1.0, style: BorderStyle.solid),
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
                        return Listener(
                          onPointerDown: (e) {
                            shouldReact = e.kind == PointerDeviceKind.mouse &&
                                e.buttons == kSecondaryMouseButton;
                          },
                          onPointerUp: (e) async {
                            if (!shouldReact) return;
                            shouldReact = false;

                            final position = Offset(
                              e.position.dx + Offset.zero.dx,
                              e.position.dy + Offset.zero.dy,
                            );

                            final selectedItem = await native.showContextMenu(
                              native.ShowMenuArgs(
                                MediaQuery.of(context).devicePixelRatio,
                                position,
                                _rightMenuFunc.menuItems ?? [],
                              ),
                            );

                            if (selectedItem != null) {
                              _rightMenuFunc.onItemSelected
                                  ?.call(selectedItem, 0);
                            }
                          },
                          child: InkWell(
                            onTap: () {
                              selectGroup = e;
                              setState(() {});
                            },
                            child: Container(
                              width: 80,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectGroup == e
                                    ? Setting.tabSelectColor
                                    : null,
                              ),
                              child: Text(e, textAlign: TextAlign.center),
                            ),
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
    );
  }
}
