import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/instructions/tab_views/instruct_main.dart';
import 'package:transaction_client/page/transaction/common/home_main.dart';

import 'instruct_sec_part.dart';

class InstructHome extends StatefulWidget {
  const InstructHome({Key? key}) : super(key: key);

  @override
  State<InstructHome> createState() => _InstructHomeState();
}

class _InstructHomeState extends State<InstructHome> {
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
        InstructMainPage(height: _controller.getArea(0).weight! *
            MediaQuery.of(context).size.height,),
        const InstructSecPartWidget(),
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
