import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/utils/screen.dart';

class RulesFunc {
  void Function(TextEditingController controller) upRule;
  void Function(TextEditingController controller) downRule;

  RulesFunc({required this.upRule, required this.downRule});
}

class TextInputNumberUpDown extends StatefulWidget {
  final FormFieldSetter<String> onSave;
  final double? height;
  final Decoration? decoration;
  final RulesFunc rulesFunc;
  final FocusNode focusNode;

  const TextInputNumberUpDown({
    Key? key,
    required this.onSave,
    required this.rulesFunc,
    required this.focusNode,
    this.height,
    this.decoration,
  }) : super(key: key);

  @override
  _TextInputNumberUpDownState createState() => _TextInputNumberUpDownState();
}

class _TextInputNumberUpDownState extends State<TextInputNumberUpDown> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      key: widget.key,
      focusNode: widget.focusNode,
      onKey: (key) {
        Log.info(key);
        Log.info(widget.key??'');
        if (key.logicalKey.debugName == 'Arrow Up') {
          widget.rulesFunc.upRule.call(controller);
        } else if (key.logicalKey.debugName == 'Arrow Down') {
          widget.rulesFunc.downRule.call(controller);
        }
      },
      child: Container(
        height: widget.height ?? 30,
        alignment: Alignment.centerLeft,
        decoration: widget.decoration ??
            BoxDecoration(
              border: Border.all(
                color: const Color(0xE6797979),
                width: 1.0,
              ),
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: widget.height ?? 30,
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00ffffff),
                          width: 0.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00ffffff),
                          width: 0.0,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 6)),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  onSaved: widget.onSave,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: screenUtil.adaptive(5)),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      widget.rulesFunc.upRule.call(controller);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: screenUtil.adaptive(12),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.rulesFunc.downRule.call(controller);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: screenUtil.adaptive(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
