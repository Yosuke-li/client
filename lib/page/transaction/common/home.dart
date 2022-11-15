import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/home_tab.dart';
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
        Area(weight: 0.15, minimalWeight: 0.15),
        Area(weight: 0.25, minimalWeight: 0.2),
        Area(weight: 0.6, minimalWeight: 0.4)
      ]);
      multiSplitView = MultiSplitView(
        axis: Axis.horizontal,
        controller: _controller,
        children: [_diskPortWidget(), _orderWidget(), const _TabView()],
        onWeightChange: () {},
      );

      theme = MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
            dividerThickness: 1.5,
            dividerPainter: DividerPainters.background(
                color: const Color(0x30333333),
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
            child: theme,
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
                  _diskPortWidget(),
                  SizedBox(
                    width: 1,
                    child: Container(
                      color: Setting.bottomBorderColor,
                    ),
                  ),
                  _orderWidget(),
                  SizedBox(
                    width: 1,
                    child: Container(
                      color: Setting.bottomBorderColor,
                    ),
                  ),
                  const Expanded(
                    child: _TabView(),
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

  Widget _diskPortWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Setting.bottomBorderColor),
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
    );
  }

  Widget _orderWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Setting.bottomBorderColor),
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
    );
  }
}

class _TabView extends StatefulWidget {
  const _TabView({Key? key}) : super(key: key);

  @override
  State<_TabView> createState() => _TabViewState();
}

class _TabViewState extends State<_TabView> with TickerProviderStateMixin {
  List<TabItem> pages = [];
  int currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    pages = initPages;
    tabController = TabController(length: 4, vsync: this)
      ..addListener(
        () {
          setState(() {
            currentIndex = tabController.index;
          });
        },
      );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Setting.bottomBorderColor),
            ),
          ),
          child: Row(
            children: pages.map((e) {
              int index = pages.indexOf(e);
              return InkWell(
                onTap: () {
                  tabController.animateTo(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
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
                  color: currentIndex == index ? Setting.tabSelectColor : null,
                  child: Text(
                    e.name,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: RepaintBoundary(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: pages.map((e) => e.page).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
