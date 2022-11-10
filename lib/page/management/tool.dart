import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
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
      key: ConstViewKey.hedgeInfo,
      tab: '交易',
      contentIfAbsent: (_) => const HomeIndexPage(),
    );
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
            height: 50,
            decoration: BoxDecoration(
              color: Setting.backGroundColor,
              border: Border(bottom: BorderSide(color: Setting.backBorderColor))
            ),
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
                          key: ConstViewKey.hedgeInfo,
                          name: '交易',
                          callback: () {
                            _handleHedgeInfoTap();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 60,
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
                          key: ConstViewKey.hedgeInfo,
                          groupName: '',
                          icon: Icon(
                            const IconData(0xe623, fontFamily: 'AliIcons'),
                            size: 30,
                            color: widget.controller.current?.key ==
                                    ConstViewKey.hedgeInfo
                                ? const Color(0xff50A250)
                                : Colors.white,
                          ),
                          callback: () {
                            _handleHedgeInfoTap();
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
      {required ViewKey key, String? name, VoidCallback? callback}) {
    return InkWell(
      onTap: () {
        callback?.call();
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '$name',
                  style: TextStyle(
                    fontWeight: widget.controller.current?.key == key
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
            Container(
              height: 4,
              color: widget.controller.current?.key == key
                  ? Setting.tabBottomColor
                  : Setting.backGroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
