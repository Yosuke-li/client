// import 'package:flutter/material.dart';
// import 'package:transaction_client/utils/log_utils.dart';
// import 'package:transaction_client/model/msg_content.dart';
// import 'package:transaction_client/widget/message_center/massage/socket_msg_control.dart';
//
// mixin SocketListener<T extends StatefulWidget> on State<T> {
//   int get msgType;
//
//   List<int> get listenerTypes;
//
//   SocketMsgControl control = SocketMsgControl();
//
//   void onListener(void Function(MsgContent msgContent) listener) {
//     control.listenEvent(listenFunc: (MsgContent msgContent) {
//       listener.call(msgContent);
//     });
//   }
//
//   @override
//   void initState() {
//     control.init(T.hashCode);
//     super.initState();
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }