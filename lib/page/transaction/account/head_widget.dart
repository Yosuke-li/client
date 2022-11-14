import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/drop_menu/overlay_field.dart';

class HeadWidgetPage extends StatefulWidget {
  const HeadWidgetPage({Key? key}) : super(key: key);

  @override
  _HeadWidgetState createState() => _HeadWidgetState();
}

class _HeadWidgetState extends State<HeadWidgetPage> {
  // List<User> users = [];
  List<String> list = ['1', '2', '3'];
  late String value;
  bool isHide = false;

  @override
  void initState() {
    super.initState();
    value = list.first;
    setState(() {});
  }

  Widget headCell({String? title, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title ：',
        ),
        Text(
          '  ${isHide ? '*****' : value}',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget lineWidget() {
    return Container(
      alignment: Alignment.center,
      width: screenUtil.adaptive(1),
      height: screenUtil.adaptive(15),
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Setting.backGroundColor,
              border: Border(
                top: BorderSide(color: Setting.bottomBorderColor),
                bottom: BorderSide(color: Setting.bottomBorderColor),
              ),
            ),
            height: screenUtil.adaptive(75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenUtil.adaptive(30),
                      width: screenUtil.adaptive(150),
                      margin: EdgeInsets.only(
                          left: screenUtil.adaptive(10),
                          right: screenUtil.adaptive(20)),
                      alignment: Alignment.center,
                      child: OverlayField<String>(
                        lists: list,
                        maxHeight: 60,
                        decoration: const BoxDecoration(
                          border: null,
                        ),
                        child: (String v) => Container(
                          height: 20,
                          child: Text('$v'),
                        ),
                        initValue: value,
                        onChange: (String v) {
                          value = v;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: screenUtil.adaptive(20),
                          right: screenUtil.adaptive(20)),
                      child: headCell(title: '静态权益', value: '10020'),
                    ),
                    lineWidget(),
                    Container(
                      margin: EdgeInsets.only(
                          left: screenUtil.adaptive(20),
                          right: screenUtil.adaptive(20)),
                      child: headCell(title: '占用保证金', value: '0'),
                    ),
                    lineWidget(),
                    Container(
                      margin: EdgeInsets.only(
                          left: screenUtil.adaptive(20),
                          right: screenUtil.adaptive(20)),
                      child: headCell(title: '可用资金', value: '10200'),
                    ),
                    InkWell(
                      onTap: () {
                        isHide = !isHide;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: screenUtil.adaptive(30)),
                        child: Icon(
                          isHide
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          size: 14,
                        ),
                      ),
                    )
                  ],
                ),
                // Container(
                //   margin: const EdgeInsets.only(right: 10),
                //   child: Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //
                //         },
                //         child: const Icon(
                //           Icons.account_balance_wallet,
                //           size: 14,
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       InkWell(
                //         onTap: () {},
                //         child: const Icon(
                //           Icons.settings,
                //           size: 14,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
