import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class InstructMainPage extends StatefulWidget {
  const InstructMainPage({Key? key}) : super(key: key);

  @override
  State<InstructMainPage> createState() => _InstructMainPageState();
}

class _InstructMainPageState extends State<InstructMainPage> {
  late MultiSplitView multiSplitView;
  late MultiSplitViewTheme theme;
  late MultiSplitViewController _controller;
  late MultiSplitView multiSplitView2;
  late MultiSplitViewTheme theme2;
  late MultiSplitViewController _controller2;

  @override
  void initState() {
    super.initState();
    _controller =
        MultiSplitViewController(areas: [Area(minimalWeight: .25, weight: .25)]);
    _controller2 =
        MultiSplitViewController(areas: [Area(weight: .5, minimalWeight: .25)]);
    multiSplitView = MultiSplitView(controller: _controller, children: [
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.lightBlue,
      ),
      Container(
        color: Colors.lightGreenAccent,
      ),
    ]);
    theme = MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.grooved1(
                color: Colors.indigo[100]!,
                highlightedColor: Colors.indigo[900]!)),
        child: multiSplitView);
    multiSplitView2 = MultiSplitView(
        axis: Axis.vertical,
        controller: _controller2,
        children: [
          Container(
            color: Colors.purple,
          ),
          theme,
        ]);
    theme2 = MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.grooved1(
                color: Colors.indigo[100]!,
                highlightedColor: Colors.indigo[900]!)),
        child: multiSplitView2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: theme2,
    );
  }
}
