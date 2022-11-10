import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/index.dart';
import 'package:transaction_client/page/login/view.dart';
import 'package:transaction_client/utils/navigator_helper.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/desktop_sys_manager.dart';
import 'package:transaction_client/widget/local_log.dart';
import 'package:transaction_client/widget/modal_utils.dart';
// import 'package:local_notifier/local_notifier.dart'; 桌面消息推送
import 'package:window_manager/window_manager.dart';

import 'utils/log_utils.dart';

void main(List<String> args) async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    // localNotifier.setup(appName: 'com.example.hedgeManager');

    await windowManager.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((value) async {
      await windowManager.setTitle('期货交易系统');
      await Setting.loginSize();
      await windowManager.show();
    });
  }
  runZonedGuarded<Future<void>>(() async {
    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) {
    _errorHandler(FlutterErrorDetails(exception: error, stack: stackTrace));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModalStyleWidget(
      child: ScreenWidget(
        child: DesktopSysManager(
          child: NavigatorInitializer(
            child: GetMaterialApp(
              builder: BotToastInit(),
              navigatorObservers: <NavigatorObserver>[
                BotToastNavigatorObserver()
              ],
              home: const IndexPage(),
            ),
          ),
        ),
      ),
    );
  }
}

//错误信息处理
void _errorHandler(FlutterErrorDetails details) async {
  LocalLog.setLog(
      '${LogLevel.ERROR.toString()} -- ${DateTime.now().toString()} -- ${details.exception}');

  if (details.exception is TimeoutException) {
    Log.info('_errorHandler TimeoutException');
  } else if (details.exception is SocketException) {
    Log.info('_errorHandler SocketException');
  } else if (details.exception is Exception) {
    Log.info('_errorHandler Exception');
  }
}
