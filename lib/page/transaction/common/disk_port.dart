import 'package:flutter/material.dart';
import 'package:transaction_client/global/order_json.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/utils/event_bus_helper.dart';

import 'package:transaction_client/utils/screen.dart';

enum DiskPortType { TypeOne, TypeTwo }

class DiskPortDetailPage extends StatefulWidget {
  final DiskPortType type;

  DiskPortDetailPage({this.type = DiskPortType.TypeOne});

  @override
  _DiskPortDetailState createState() => _DiskPortDetailState();
}

class DiskPortDetail {
  String? name;
  String? code;
  String? value;

  DiskPortDetail({this.name, this.value, this.code});
}

class _DiskPortDetailState extends State<DiskPortDetailPage> {
  List<DiskPortDetail> disk = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    disk = [
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '2',
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '2',
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '2',
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '4',
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '15',
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '10',
      DiskPortDetail()
        ..code = '146190'
        ..name = '卖五'
        ..value = '15',
    ];
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant DiskPortDetailPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {}
  }

  // todo 假数据暂用dynamic代替
  void _toSendPrice(dynamic price) {
    if (price != null) {
      EventBusHelper.asyncStreamController?.add(EventSelect()..price = price);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        child: Container(
          alignment: Alignment.center,
          child: widget.type == DiskPortType.TypeOne
              ? Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: disk.map((e) {
                          return InkWell(
                            onTap: () {
                              _toSendPrice(e.code);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: screenUtil.adaptive(15),
                                  left: screenUtil.adaptive(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${e.name}'),
                                  Text(
                                    '${e.code}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text('${e.value}'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: screenUtil.adaptive(10),
                          bottom: screenUtil.adaptive(10)),
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Setting.backBorderColor,
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: disk.map((e) {
                          return InkWell(
                            onTap: () {
                              _toSendPrice(e.value);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: screenUtil.adaptive(15),
                                  left: screenUtil.adaptive(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${e.name}'),
                                  Text(
                                    '${e.code}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text('${e.value}'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: screenUtil.adaptive(10),
                          bottom: screenUtil.adaptive(10)),
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Setting.backBorderColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: screenUtil.adaptive(15),
                          left: screenUtil.adaptive(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('涨停'),
                          Text(
                            '155121',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: screenUtil.adaptive(15),
                          left: screenUtil.adaptive(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('跌停'),
                          Text(
                            '155121',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: screenUtil.adaptive(10),
                          bottom: screenUtil.adaptive(10)),
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Setting.backBorderColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: screenUtil.adaptive(15),
                          left: screenUtil.adaptive(15),
                          bottom: screenUtil.adaptive(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('昨收'),
                          Text(
                            '155121',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
