import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/instructions/instruct_main.dart';
import 'package:transaction_client/page/transaction/common/home_main.dart';
import 'package:transaction_client/page/transaction/quotation/quotation.dart';
import 'package:transaction_client/utils/log_utils.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({
    Key? key,
  }) : super(key: key);

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
        Area(weight: 0.35, minimalWeight: 0.2),
        Area(weight: 0.65, minimalWeight: 0.57)
      ]);
      init();
      setState(() {});
    });
  }

  void init() {
    try {
      multiSplitView = MultiSplitView(
        axis: Axis.vertical,
        controller: _controller,
        children: [
          QuotationPage(
            height: (_controller.getArea(0).weight! *
                MediaQuery.of(context).size.height),
          ),
          const HomeBottomMain(
            key: Key('quotation'),
          )
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
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return theme ?? Container();
  }
}
