import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/account.dart';
import 'package:transaction_client/model/entrust.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

part 'tab_views/tab_view.dart';

enum InstructType {
  all,
  doing,
  finish,
  none,
}

extension InstructTypeTxt on InstructType {
  String get enumToString {
    switch (this) {
      case InstructType.all:
        return '全部';
      case InstructType.doing:
        return '进行中';
      case InstructType.none:
        return '未认领';
      case InstructType.finish:
        return '已完成';
    }
  }
}

class InstructMainPage extends StatefulWidget {
  final double? height;

  const InstructMainPage({Key? key, this.height}) : super(key: key);

  @override
  State<InstructMainPage> createState() => _InstructMainPageState();
}

class _InstructMainPageState extends State<InstructMainPage> {
  InstructType type = InstructType.all;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Setting.backGroundColor,
          child: Row(
            children: InstructType.values.map((e) {
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
                  height: 30,
                  color: type == e ? Setting.tabSelectColor : null,
                  child: Text(
                    e.enumToString,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: RepaintBoundary(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _TypeToTablePage(
                      type: type,
                    ),
                  ],
                ),
              )
            )
          ],
        )),
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
                    '认领',
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
                  child: const Text('虚拟对冲',
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
                  child: const Text('完成指令',
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
                  child: const Text('配单',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
