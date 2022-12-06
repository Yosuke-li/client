
import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/home_tab.dart';
import 'package:transaction_client/utils/screen.dart';

/// 订单信息
class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => TabViewState();
}

class TabViewState extends State<TabView> with TickerProviderStateMixin {
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
    return Container(
      margin: const EdgeInsets.only(left: 0.6),
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
                    color:
                    currentIndex == index ? Setting.tabSelectColor : null,
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
      ),
    );
  }
}