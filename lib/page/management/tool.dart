import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/auto_strategy/strategy_home.dart';
import 'package:transaction_client/page/instructions/instruct_home.dart';
import 'package:transaction_client/page/transaction/common/home.dart';
import 'package:transaction_client/widget/management/common/view_key.dart';
import 'package:transaction_client/widget/management/widget/custom_expansion_tile.dart';
import 'dart:math' as math;

import 'editor.dart';

class Tool extends StatefulWidget {
  final EditorController controller;
  final bool isVertical;

  const Tool({Key? key, required this.controller, required this.isVertical})
      : super(key: key);

  @override
  _ToolState createState() => _ToolState();
}

class _GroupItem {
  final String title;
  final VoidCallback callback;

  _GroupItem(this.title, this.callback);
}

class _ToolState extends State<Tool> {
  final Map<String, bool> expanded = <String, bool>{};

  void _handleHedgeInfoTap() {
    widget.controller.open(
      key: ConstViewKey.transactionInfo,
      tab: '交易',
      contentIfAbsent: (_) => const HomeIndexPage(),
    );
    setState(() {});
  }

  void _handleInstructInfoTap() {
    widget.controller.open(
      key: ConstViewKey.instructInfo,
      tab: '指令下单',
      contentIfAbsent: (_) => const InstructHome(),
    );
    setState(() {});
  }

  void _handleAutoStrategyTap() {
    widget.controller.open(
      key: ConstViewKey.autoStrategy,
      tab: '自动策略',
      contentIfAbsent: (_) => const AutoStrategyHome(),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handleHedgeInfoTap();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isVertical
        ? Container(
            height: Setting.tabBarHeight,
            decoration: BoxDecoration(
                color: Setting.backGroundColor,
                border:
                    Border(bottom: BorderSide(color: Setting.backBorderColor))),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Setting.isVertical = !Setting.isVertical;
                    setState(() {});
                  },
                  child: const SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(
                      IconData(0xec2e, fontFamily: 'AliIcons'),
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      buildHToolButton(
                        key: ConstViewKey.transactionInfo,
                        isSelect: widget.controller.current?.key ==
                            ConstViewKey.transactionInfo,
                        name: '交易',
                        callback: () {
                          _handleHedgeInfoTap();
                        },
                      ),
                      buildHToolButton(
                        key: ConstViewKey.instructInfo,
                        isSelect: widget.controller.current?.key ==
                            ConstViewKey.instructInfo,
                        name: '指令下单',
                        callback: () {
                          _handleInstructInfoTap();
                        },
                      ),
                      buildHToolButton(
                        key: ConstViewKey.autoStrategy,
                        isSelect: widget.controller.current?.key ==
                            ConstViewKey.autoStrategy,
                        name: '自动策略',
                        callback: () {
                          _handleAutoStrategyTap();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: Setting.tabBarWidth,
            padding: const EdgeInsets.only(bottom: 10),
            color: const Color(0xff333333),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Setting.isVertical = !Setting.isVertical;
                    setState(() {});
                  },
                  child: const SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(
                      IconData(0xec2e, fontFamily: 'AliIcons'),
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Material(
                        type: MaterialType.transparency,
                        child: buildToolGroup(
                          key: ConstViewKey.transactionInfo,
                          groupName: '',
                          icon: Icon(
                            const IconData(0xe623, fontFamily: 'AliIcons'),
                            size: 30,
                            color: widget.controller.current?.key ==
                                    ConstViewKey.transactionInfo
                                ? const Color(0xff50A250)
                                : Colors.white,
                          ),
                          callback: () {
                            _handleHedgeInfoTap();
                          },
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: buildToolGroup(
                          key: ConstViewKey.instructInfo,
                          groupName: '',
                          icon: Icon(
                            const IconData(0xe623, fontFamily: 'AliIcons'),
                            size: 30,
                            color: widget.controller.current?.key ==
                                    ConstViewKey.instructInfo
                                ? const Color(0xff50A250)
                                : Colors.white,
                          ),
                          callback: () {
                            _handleInstructInfoTap();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildToolGroup(
      {required ViewKey key,
      required String groupName,
      List<_GroupItem>? groupItems,
      VoidCallback? callback,
      VoidCallback? longPressCallBack,
      Widget? icon}) {
    return CustomExpansionTile(
      value: expanded[groupName] == true,
      customHead: (_, animation) => InkWell(
        child: SizedBox(
          width: 60,
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      icon ??
                          Transform.rotate(
                            angle: math.pi * (1.5 + animation.value / 2),
                            child: const Icon(
                              Icons.expand_more,
                              size: 16,
                            ),
                          ),
                      if (groupName.isNotEmpty)
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            groupName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Container(
                width: 4,
                color: widget.controller.current?.key == key
                    ? const Color(0xff50A250)
                    : const Color(0xff333333),
              ),
            ],
          ),
        ),
        onLongPress: () {
          longPressCallBack?.call();
        },
        onTap: () {
          if (callback != null) {
            callback.call();
          } else {
            if (expanded[groupName] == null) {
              expanded[groupName] = true;
            } else {
              expanded[groupName] = !expanded[groupName]!;
            }
          }
          setState(() {});
        },
      ),
      children: groupItems
              ?.map((e) => InkWell(
                    onTap: e.callback,
                    child: Container(
                      padding: const EdgeInsets.all(8.0).copyWith(left: 32),
                      alignment: Alignment.centerLeft,
                      child: Text(e.title),
                    ),
                  ))
              .toList(growable: false) ??
          [],
    );
  }

  Widget buildHToolButton(
      {required ViewKey key,
      String? name,
      VoidCallback? callback,
      bool isSelect = false}) {
    return InkWell(
      onTap: () {
        callback?.call();
      },
      child: Container(
        width: 100,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '$name',
                  style: TextStyle(
                    fontWeight: isSelect ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
            Container(
              height: 4,
              color:
                  isSelect ? Setting.tabBottomColor : Setting.backGroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
