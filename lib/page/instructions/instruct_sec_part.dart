import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:transaction_client/global/global.dart';
import 'package:transaction_client/global/order_json.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/model/home_tab.dart';
import 'package:transaction_client/page/common/common_tab_view.dart';
import 'package:transaction_client/page/instructions/instruct_order/view.dart';
import 'package:transaction_client/page/instructions/instruct_utils/eventbus.dart';
import 'package:transaction_client/page/transaction/account/head_widget.dart';
import 'package:transaction_client/page/transaction/common/disk_port.dart';
import 'package:transaction_client/page/transaction/order/order_submit/view.dart';
import 'package:transaction_client/utils/event_bus_helper.dart';
import 'package:transaction_client/utils/screen.dart';

class InstructSecPartWidget extends StatefulWidget {
  const InstructSecPartWidget({Key? key}) : super(key: key);

  @override
  State<InstructSecPartWidget> createState() => _InstructSecPartWidgetState();
}

class _InstructSecPartWidgetState extends State<InstructSecPartWidget> {
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
        children: const [_DiskPortWidget(), _OrderView(), TabView()],
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

/// ????????????
class _OrderView extends StatefulWidget {
  const _OrderView({Key? key}) : super(key: key);

  @override
  State<_OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<_OrderView> {
  @override
  Widget build(BuildContext context) {
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
                      '????????????',
                    ),
                  )
                ],
              )),
          Expanded(
            child: InstructOrderPage(),
          ),
        ],
      ),
    );
  }
}

/// ????????????
class _DiskPortWidget extends StatefulWidget {
  const _DiskPortWidget({Key? key}) : super(key: key);

  @override
  State<_DiskPortWidget> createState() => _DiskPortWidgetState();
}

class _DiskPortWidgetState extends State<_DiskPortWidget> {
  dynamic _select;
  DiskPortType type = DiskPortType.TypeOne;

  @override
  void initState() {
    super.initState();
    _eventBusListen();
  }

  void _eventBusListen() {
    EventBusHelper.listen<InstructEventBus>((event) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
      child: Column(
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
                  child: Text(
                    '????????????[${_select?.username ?? ''}]',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (type == DiskPortType.TypeOne) {
                      type = DiskPortType.TypeTwo;
                    } else {
                      type = DiskPortType.TypeOne;
                    }
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.sync_alt,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              child: DiskPortDetailPage(
                type: type,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
