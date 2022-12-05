import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/account.dart';
import 'package:transaction_client/model/entrust.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

part 'tab_view.dart';

enum AutoStrategyType {
  all,
  doing,
  stop,
}

extension AutoStrategyTxt on AutoStrategyType {
  String get enumToString {
    switch (this) {
      case AutoStrategyType.all:
        return '全部';
      case AutoStrategyType.doing:
        return '执行中';
      case AutoStrategyType.stop:
        return '暂停';
    }
  }
}

class AutoStrategyMain extends StatefulWidget {
  final double height;

  const AutoStrategyMain({Key? key, required this.height}) : super(key: key);

  @override
  State<AutoStrategyMain> createState() => _AutoStrategyPageState();
}

class _AutoStrategyPageState extends State<AutoStrategyMain> {
  AutoStrategyType type = AutoStrategyType.all;
  late double height;


  @override
  void initState() {
    setHeight();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AutoStrategyMain oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height) {
      setHeight();
    }
  }

  /// 计算高度
  void setHeight() {
    height = widget.height -
        Setting.tabBarHeight -
        Setting.tabBarSecHeight - 20;
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Setting.backGroundColor,
          child: Row(
            children: AutoStrategyType.values.map((e) {
              return InkWell(
                onTap: () {
                  type = e;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(
                    right: screenUtil.adaptive(40),
                    left: screenUtil.adaptive(40),
                    top: screenUtil.adaptive(3),
                    bottom: screenUtil.adaptive(3),
                  ),
                  alignment: Alignment.center,
                  height: Setting.tabBarSecHeight,
                  color: type == e ? Setting.tabSelectColor : null,
                  child: Text(
                    e.enumToString,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: RepaintBoundary(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _TypeToTablePage(
                          type: type,
                          height: height,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
