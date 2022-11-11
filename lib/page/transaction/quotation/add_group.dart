import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';

class AddGroupsPage extends StatefulWidget {
  const AddGroupsPage({Key? key}) : super(key: key);

  @override
  State<AddGroupsPage> createState() => _AddGroupsPageState();
}

class _AddGroupsPageState extends State<AddGroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 18),
            child: const Text(
              '请输入新建订阅组的名称',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Setting.onSubmitColor),
                  ),
                  child: Container(
                    height: 31,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: const Text(
                      '确定',
                      style: TextStyle(color: Color(0xff333333)),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Setting.onCancelColor),
                  ),
                  child: Container(
                    height: 31,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: const Text(
                      '取消',
                      style: TextStyle(color: Color(0xff333333)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
