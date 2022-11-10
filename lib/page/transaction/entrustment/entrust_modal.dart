import 'package:flutter/material.dart';
import 'package:transaction_client/utils/navigator.dart';
import 'package:transaction_client/widget/modal_utils.dart';

class EntrustModal {
  static Future<bool?> Modal(BuildContext context,
      {required Widget child, required String title, ModalSize? size,}) async {
    double height = 470;
    if (size != null && size.height != null) {
      height = size.height! - 40;
    }
    return await ModalUtils.showModal(
      context,
      isDrag: true,
      modalSize: size ?? ModalSize(width: null, height: 510),
      body: Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${title}',
                      style: const TextStyle(fontSize: 20),
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
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }

}