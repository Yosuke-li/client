import 'package:flutter/material.dart';
import 'package:transaction_client/page/transaction/order/order_select.dart';
import 'package:transaction_client/utils/navigator.dart';
import 'package:transaction_client/widget/modal_utils.dart';

class Order {
  static Future<void> Modal(BuildContext context,
      {void Function()? onFunc}) async {
    await ModalUtils.showModal(
      context,
      marginBottom: 20,
      modalSize: ModalSize(width: null, height: 510),
      body: Container(
        alignment: Alignment.center,
        height: 470,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '选择合约',
                      style: TextStyle(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        NavigatorUtils.pop(context);
                      },
                      child: const Icon(Icons.close),
                    )
                  ],
                )
            ),
            const Expanded(
              child: OrderSelect(),
            ),
          ],
        ),
      ),
    );
  }
}
