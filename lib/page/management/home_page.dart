import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/transaction/common/bottom_widget.dart';
import 'package:transaction_client/utils/log_utils.dart';

import 'editor.dart';
import 'tool.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeChildPage();
  }
}

class _HomeChildPage extends StatefulWidget {
  @override
  _HomeChildPageState createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<_HomeChildPage> {
  EditorController editorController = EditorController();
  bool isVertical = Setting.isVertical;

  @override
  void dispose() {
    editorController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: isVertical
            ? Column(
                children: [
                  Tool(
                    key: Key(editorController.hashCode.toString()),
                    controller: editorController,
                    isVertical: isVertical,
                  ),
                  Expanded(
                    child: Editor(
                      key: Key(editorController.hashCode.toString()),
                      controller: editorController,
                    ),
                  ),
                  const BottomWidgetPage(),
                ],
              )
            : Row(
                children: [
                  Tool(
                    key: Key(editorController.hashCode.toString()),
                    controller: editorController,
                    isVertical: isVertical,
                  ),
                  Expanded(
                    child: Editor(
                      key: Key(editorController.hashCode.toString()),
                      controller: editorController,
                    ),
                  ),
                  const BottomWidgetPage(),
                ],
              ),
      ),
    );
  }
}
