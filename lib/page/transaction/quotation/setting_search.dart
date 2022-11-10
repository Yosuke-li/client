import 'package:flutter/material.dart';
import 'package:transaction_client/page/transaction/quotation/other_action.dart';
import 'package:transaction_client/page/transaction/quotation/setting.dart';
import 'package:transaction_client/utils/log_utils.dart';

import 'package:transaction_client/utils/navigator.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/api_call_back.dart';
import 'package:transaction_client/widget/drop_menu/overlay_field.dart';
import 'package:transaction_client/widget/group_list.dart';
import 'package:transaction_client/widget/management/widget/common_form.dart';

class SettingSearch extends StatefulWidget {
  const SettingSearch({Key? key}) : super(key: key);

  @override
  State<SettingSearch> createState() => _SettingSearchState();
}

class _SettingSearchState extends State<SettingSearch> {
  late List<GroupListModel<GroupListModel<String>>> data;

  // init数据
  List<String> _exchange = <String>['1', '2', '3', '32', '4', '13', '23'];
  final TextEditingController _controller = TextEditingController();
  late String exchange;

  List<String> exchanges = ['12', '23', '4', '61', '56'];

  String select = '1';
  bool select_all = false;

  // method数据
  List<String> _show_list = [];
  List<String> _group_list = [];
  List<String> _select_add_list = [];
  List<String> _select_del_list = [];

  @override
  void initState() {
    data = [
      GroupListModel<GroupListModel<String>>()
        ..title = 'main'
        ..children = [
          GroupListModel<String>()
            ..title = '1'
            ..children = ['1', '2', '3'],
          GroupListModel<String>()
            ..title = '2'
            ..children = ['1', '2', '3'],
        ],
      GroupListModel<GroupListModel<String>>()
        ..title = 'main 2'
        ..children = [
          GroupListModel<String>()
            ..title = '3'
            ..children = ['1', '2', '3'],
          GroupListModel<String>()
            ..title = '4'
            ..children = ['1', '2', '3'],
        ],
    ];
    super.initState();
    exchange = exchanges.first;
    _show_list = exchanges;
    setState(() {});
  }

  // 搜索
  Future<void> _search(String key) async {
    if (key.isNotEmpty == true) {
      _show_list =
          exchanges.where((String element) => element.contains(key)).toList();
    } else {
      _show_list = exchanges;
    }
    setState(() {});
  }

  // button 添加
  Future<void> _add() async {}

  // button 删除
  Future<void> _delete() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff797979), width: 1)),
                          hintText: '请搜索',
                          suffixIcon: Icon(Icons.search)),
                      controller: _controller,
                      onChanged: (String value) async {
                        await loadingCallback(() => _search(value));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GroupListWidget<GroupListModel<String>>(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 5),
            list: data,
            title: (String d) {
              return Container(
                child: Text(
                  d,
                  style: const TextStyle(fontSize: 19),
                ),
              );
            },
            groupItemBuilder: (GroupListModel<String> d) {
              return GroupListWidget<String>(
                padding: const EdgeInsets.all(5),
                list: [d],
                title: (String d) {
                  return Container(
                    child: Text(
                      d,
                      style: const TextStyle(fontSize: 17),
                    ),
                  );
                },
                groupItemBuilder: (String value) {
                  return Container(
                    margin:
                    const EdgeInsets.only(right: 30, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('CU2212'),
                        ),
                        Container(
                          child: Text('沪铜2212'),
                        ),
                        Container(
                          child: Text('期货'),
                        ),
                        Container(
                          child: Text('操作'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
