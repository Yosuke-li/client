part of 'auto_main.dart';

class _TypeToTablePage extends StatefulWidget {
  final AutoStrategyType type;
  final double height;

  const _TypeToTablePage({Key? key, required this.type, required this.height})
      : super(key: key);

  @override
  State<_TypeToTablePage> createState() => _TypeToTablePageState();
}

class _TypeToTablePageState extends State<_TypeToTablePage>
    with AutomaticKeepAliveClientMixin {
  List<Account> users = [

    Account()
      ..username = 'CU202203'
      ..password = 'DCE'
      ..entrusts = [
        (Entrust()
          ..id = 1
          ..price = '2')
      ],
    Account()
      ..username = 'ZH202203'
      ..password = 'CZCE'
      ..entrusts = [
        (Entrust()
          ..id = 3
          ..price = '2'),
        (Entrust()
          ..id = 4
          ..price = '2'),
      ],
  ];
  double? height;

  /// 实现控制表格height
  final StreamController<double> controller = StreamController<double>();

  @override
  void initState() {
    super.initState();
    setHeight();
  }

  @override
  void didUpdateWidget(covariant _TypeToTablePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height) {
      setHeight();
    }
  }

  /// 计算高度
  void setHeight() {
    height = widget.height;
    controller.sink.add(height!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<double>(
      stream: controller.stream,
      initialData: height,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return CommonForm<Account, Entrust>(
          onTapFunc: (Account value) {},
          childValues: (Account value) {
            return value.entrusts ?? [];
          },
          height: snapshot.data as double,
          childWidget: [
            FormChildColumn<Entrust>(
              title: const Text(
                '合约',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.id}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '现价',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '涨幅',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '涨跌',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '买价',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '卖价',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '开盘价',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormChildColumn<Entrust>(
              title: const Text(
                '昨日结算价',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              builder: (_, v) => Text(
                '${v.price}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
          titleColor: Setting.tableBarColor,
          columns: [
            FormColumn<Account>(
              title: const Text(
                '策略名称',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              width: MediaQuery.of(context).size.width / 5,
              builder: (_, v) => Text(
                '${users.indexOf(v)}',
                style: TextStyle(
                  fontSize: 13,
                  color: Setting.tableBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            FormColumn<Account>(
              title: const Text(
                '策略类型',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              width: MediaQuery.of(context).size.width / 5,
              builder: (_, v) => Container(
                child: Text(
                  v.username ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    color: Setting.tableBlue,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            FormColumn<Account>(
              title: const Text(
                '执行条件',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              width: MediaQuery.of(context).size.width / 5,
              builder: (_, v) => Container(
                child: Text(
                  '${v.username ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Setting.tableBlue,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            FormColumn<Account>(
              title: const Text(
                '条件价格',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              width: MediaQuery.of(context).size.width / 5,
              builder: (_, v) => Container(
                child: Text(
                  '${v.password ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Setting.tableRed,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            FormColumn<Account>(
              title: const Text(
                '策略状态',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
              width: MediaQuery.of(context).size.width / 5,
              builder: (_, v) => Container(
                child: Text(
                  '${v.password ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Setting.tableRed,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
          values: users,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
