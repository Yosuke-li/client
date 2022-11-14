import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/transaction/account/head_widget.dart';
import 'package:transaction_client/page/transaction/common/bottom_widget.dart';
import 'package:transaction_client/page/transaction/quotation/quotation.dart';
import 'package:transaction_client/utils/screen.dart';

import '../entrustment/entrustment.dart';
import '../order/order_submit/view.dart';
import 'disk_port.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({Key? key}) : super(key: key);

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  late MultiSplitView multiSplitView;
  MultiSplitViewTheme? theme;
  late MultiSplitViewController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller = MultiSplitViewController(areas: [
        Area(minimalWeight: .05, weight: .35),
        Area(minimalWeight: .3),
      ]);
      multiSplitView = MultiSplitView(
        axis: Axis.vertical,
        controller: _controller,
        children: [const QuotationPage(), _buildContainer()],
        onWeightChange: () {

        },
      );

      theme = MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.grooved1(
                color: Colors.indigo[100]!,
                highlightedColor: Colors.indigo[900]!)),
        child: multiSplitView,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const QuotationPage(),
        const HeadWidgetPage(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Setting.bottomBorderColor),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                            BorderSide(color: Setting.bottomBorderColor),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                right: screenUtil.adaptive(10),
                                left: screenUtil.adaptive(8),
                                top: screenUtil.adaptive(5),
                                bottom: screenUtil.adaptive(5),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                '盘口信息[合约]',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: RepaintBoundary(
                          child: DiskPortDetailPage(
                            type: DiskPortType.TypeOne,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1,
                  child: Container(
                    color: Setting.bottomBorderColor,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Setting.bottomBorderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  right: screenUtil.adaptive(15),
                                  left: screenUtil.adaptive(15),
                                  top: screenUtil.adaptive(3),
                                  bottom: screenUtil.adaptive(3),
                                ),
                                alignment: Alignment.center,
                                height: 30,
                                color: Setting.tabSelectColor,
                                child: const Text(
                                  '期货下单',
                                ),
                              )
                            ],
                          )),
                      Expanded(
                        child: OrderSubmitPage(
                          showTitle: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1,
                  child: Container(
                    color: Setting.bottomBorderColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                            BorderSide(color: Setting.bottomBorderColor),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                right: screenUtil.adaptive(25),
                                left: screenUtil.adaptive(25),
                                top: screenUtil.adaptive(3),
                                bottom: screenUtil.adaptive(3),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              color: Setting.tabSelectColor,
                              child: const Text(
                                '挂单',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: screenUtil.adaptive(25),
                                left: screenUtil.adaptive(25),
                                top: screenUtil.adaptive(3),
                                bottom: screenUtil.adaptive(3),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                '成交单',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: screenUtil.adaptive(25),
                                left: screenUtil.adaptive(25),
                                top: screenUtil.adaptive(3),
                                bottom: screenUtil.adaptive(3),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                '持仓',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: screenUtil.adaptive(25),
                                left: screenUtil.adaptive(25),
                                top: screenUtil.adaptive(3),
                                bottom: screenUtil.adaptive(3),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                '资金',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: RepaintBoundary(
                          child: EntrustPage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const BottomWidgetPage(),
      ],
    );
  }

  Widget _buildContainer() {
    return Container(
      child: Column(
        children: [
          const HeadWidgetPage(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Setting.bottomBorderColor),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Setting.bottomBorderColor),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  right: screenUtil.adaptive(10),
                                  left: screenUtil.adaptive(8),
                                  top: screenUtil.adaptive(5),
                                  bottom: screenUtil.adaptive(5),
                                ),
                                alignment: Alignment.center,
                                height: 30,
                                child: const Text(
                                  '盘口信息[合约]',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RepaintBoundary(
                            child: DiskPortDetailPage(
                              type: DiskPortType.TypeOne,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    child: Container(
                      color: Setting.bottomBorderColor,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Setting.bottomBorderColor),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: screenUtil.adaptive(15),
                                    left: screenUtil.adaptive(15),
                                    top: screenUtil.adaptive(3),
                                    bottom: screenUtil.adaptive(3),
                                  ),
                                  alignment: Alignment.center,
                                  height: 30,
                                  color: Setting.tabSelectColor,
                                  child: const Text(
                                    '期货下单',
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                          child: OrderSubmitPage(
                            showTitle: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    child: Container(
                      color: Setting.bottomBorderColor,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Setting.bottomBorderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  right: screenUtil.adaptive(25),
                                  left: screenUtil.adaptive(25),
                                  top: screenUtil.adaptive(3),
                                  bottom: screenUtil.adaptive(3),
                                ),
                                alignment: Alignment.center,
                                height: 30,
                                color: Setting.tabSelectColor,
                                child: const Text(
                                  '挂单',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  right: screenUtil.adaptive(25),
                                  left: screenUtil.adaptive(25),
                                  top: screenUtil.adaptive(3),
                                  bottom: screenUtil.adaptive(3),
                                ),
                                alignment: Alignment.center,
                                height: 30,
                                child: const Text(
                                  '成交单',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  right: screenUtil.adaptive(25),
                                  left: screenUtil.adaptive(25),
                                  top: screenUtil.adaptive(3),
                                  bottom: screenUtil.adaptive(3),
                                ),
                                alignment: Alignment.center,
                                height: 30,
                                child: const Text(
                                  '持仓',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  right: screenUtil.adaptive(25),
                                  left: screenUtil.adaptive(25),
                                  top: screenUtil.adaptive(3),
                                  bottom: screenUtil.adaptive(3),
                                ),
                                alignment: Alignment.center,
                                height: 30,
                                child: const Text(
                                  '资金',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: RepaintBoundary(
                            child: EntrustPage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const BottomWidgetPage(),
        ],
      ),
    );
  }
}
