import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/auto_strategy/strategy_page/strategy_page.dart';
import 'package:transaction_client/page/common/common_tab_view.dart';
import 'package:transaction_client/page/transaction/account/head_widget.dart';
import 'package:transaction_client/utils/screen.dart';

class StrategySecPartWidget extends StatefulWidget {
  const StrategySecPartWidget({Key? key}) : super(key: key);

  @override
  State<StrategySecPartWidget> createState() => _StrategySecPartWidgetState();
}

class _StrategySecPartWidgetState extends State<StrategySecPartWidget> {
  late MultiSplitView multiSplitView;
  MultiSplitViewTheme? theme;
  late MultiSplitViewController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller = MultiSplitViewController(areas: [
        Area(weight: 0.5, minimalWeight: 0.25),
        Area(weight: 0.5, minimalWeight: 0.25),
      ]);
      multiSplitView = MultiSplitView(
        axis: Axis.horizontal,
        controller: _controller,
        children: const [_AutoStrategyWidget(), TabView()],
        onWeightChange: () {},
      );
      theme = MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
            dividerThickness: 0.5,
            dividerPainter: DividerPainters.background(
                color: Setting.backBorderColor,
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
      ],
    );
  }
}

class _AutoStrategyWidget extends StatefulWidget {
  const _AutoStrategyWidget({Key? key}) : super(key: key);

  @override
  State<_AutoStrategyWidget> createState() => _AutoStrategyWidgetState();
}

class _AutoStrategyWidgetState extends State<_AutoStrategyWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(right: 5),
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
                color: Setting.tabSelectColor,
                child: const Text(
                  '自动策略',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              InkWell(
                onTap: () {

                },
                child: const Icon(
                  Icons.add_box_outlined,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: StrategyPage(),
        ),
      ],
    );
  }
}

