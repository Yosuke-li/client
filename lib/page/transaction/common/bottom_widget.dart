import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/utils/navigator.dart';
import 'package:transaction_client/utils/screen.dart';

class BottomWidgetPage extends StatefulWidget {
  const BottomWidgetPage({Key? key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidgetPage> {
  DateTime now = DateTime.now();
  late void Function() _timer;

  void startClock() {
    _timer = Timer.periodic(const Duration(microseconds: 1000), (Timer t) {
      if (!mounted) {
        return;
      }
      setState(() {
        now = DateTime.now();
      });
    }).cancel;
    setState(() {});
  }

  String pad0(int num) {
    if (num < 10) {
      return '0${num.toString()}';
    }
    return num.toString();
  }

  @override
  void initState() {
    super.initState();
    startClock();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 流实现?
          Expanded(child: Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text('风控记录'),
                  ),
                ),
                SizedBox(
                  height: 22,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Setting.backGroundColor),
                    ),
                    child: const Text(
                      '更多记录',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),),
          SizedBox(
            height: 35,
            width: 1,
            child: Container(
              color: Setting.backGroundColor,
            ),
          ),
          RepaintBoundary(
            child: Container(
              margin: const EdgeInsets.only(left: 20,),
              width: 150,
              child: Text(
                  '${now.year}-${now.month}-${now.day} ${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}'),
            ),
          ),
        ],
      ),
    );
  }
}
