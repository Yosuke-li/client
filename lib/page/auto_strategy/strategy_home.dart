import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/auto_strategy/strategy_sec_part.dart';

import 'tab_views/auto_main.dart';

class AutoStrategyHome extends StatefulWidget {
  const AutoStrategyHome({Key? key}) : super(key: key);

  @override
  State<AutoStrategyHome> createState() => _AutoStrategyHomeState();
}

class _AutoStrategyHomeState extends State<AutoStrategyHome> {
  late MultiSplitView multiSplitView;
  MultiSplitViewTheme? theme;
  late MultiSplitViewController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller = MultiSplitViewController(areas: [
        Area(weight: 0.4, minimalWeight: 0.2),
        Area(weight: 0.6, minimalWeight: 0.57)
      ]);
      init();
      setState(() {});
    });
  }

  void init() {
    multiSplitView = MultiSplitView(
      axis: Axis.vertical,
      controller: _controller,
      children: [
        AutoStrategyMain(height: _controller.getArea(0).weight! *
            MediaQuery.of(context).size.height,),
        const StrategySecPartWidget(),
      ],
      onWeightChange: () {
        init();
      },
    );

    theme = MultiSplitViewTheme(
      data: MultiSplitViewThemeData(
        dividerPainter: DividerPainters.grooved1(
            color: Setting.backBorderColor,
            highlightedColor: Colors.indigo[900]!),
      ),
      child: multiSplitView,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return theme ?? Container();
  }
}
