import 'package:flutter/material.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/transaction/quotation/add_group.dart';
import 'package:transaction_client/page/transaction/quotation/other_action.dart';
import 'package:transaction_client/page/transaction/quotation/setting_search.dart';
import 'package:transaction_client/utils/navigator.dart';
import 'package:transaction_client/widget/modal_utils.dart';

class QuoSetting {
  static Future<void> Modal(BuildContext context,
      {void Function()? onFunc}) async {
    await ModalUtils.showModal(
      context,
      isDrag: true,
      header: Container(
          padding:
              const EdgeInsets.only(right: 20, top: 10, left: 20, bottom: 10),
          margin: const EdgeInsets.only(bottom: 10),
          color: Setting.tableBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '添加订阅合约',
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () {
                  NavigatorUtils.pop(context);
                },
                child: const Icon(Icons.close),
              )
            ],
          )),
      modalSize: ModalSize(width: 400, height: 600),
      body: Container(
        alignment: Alignment.center,
        height: 600,
        child: const SettingSearch(
          key: Key('SettingSearch'),
        ),
      ),
    );
  }

  static Future<bool?> otherAction(BuildContext context,
      {void Function()? onFunc, String? title, required OtherType type}) async {
    return await ModalUtils.showModal(
      context,
      modalSize:
          ModalSize(width: 300, height: type == OtherType.Delete ? 210 : 220),
      body: Container(
        alignment: Alignment.center,
        height: type == OtherType.Delete ? 180 : 190,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    right: 20, top: 10, left: 20, bottom: 10),
                margin: const EdgeInsets.only(bottom: 10),
                color: Setting.tableBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${title ?? ''}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        NavigatorUtils.pop(context);
                      },
                      child: const Icon(Icons.close),
                    )
                  ],
                )),
            Expanded(
              child: OtherAction(
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 添加订阅组
  static Future<void> addGroups(BuildContext context,
      {void Function()? onFunc}) async {
    await ModalUtils.showModal(
      context,
      isDrag: true,
      header: Container(
          padding:
              const EdgeInsets.only(right: 20, top: 10, left: 20, bottom: 10),
          margin: const EdgeInsets.only(bottom: 10),
          color: Setting.tableBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '添加订阅组',
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () {
                  NavigatorUtils.pop(context);
                },
                child: const Icon(Icons.close),
              )
            ],
          )),
      modalSize: ModalSize(width: 400, height: 230),
      body: Container(
        alignment: Alignment.center,
        height: 170,
        child: const AddGroupsPage(),
      ),
    );
  }
}
