import 'package:flutter/material.dart';
import 'package:transaction_client/page/login/view.dart';
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/utils/store.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  void initState() {
    Log.init(isDebug: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
