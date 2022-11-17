import 'package:flutter/material.dart';
import 'package:transaction_client/utils/screen.dart';

class TextInputLock extends StatefulWidget {
  final FormFieldSetter<String> onSave;
  double? height;
  Decoration? decoration;

  TextInputLock({required this.onSave, this.height, this.decoration});

  @override
  _TextInputLockState createState() => _TextInputLockState();
}

class _TextInputLockState extends State<TextInputLock> {
  bool onLock = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 30,
      decoration: widget.decoration ?? BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: const Color(0xff797979),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
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
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 6),
              ),
              readOnly: onLock,
              onSaved: widget.onSave,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: screenUtil.adaptive(5)),
            child: InkWell(
              onTap: () {
                onLock = !onLock;
                setState(() {});
              },
              child: Icon(
                onLock ? Icons.lock : Icons.lock_open,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
