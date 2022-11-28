part of '../instruct_main.dart';

class _TypeToTablePage extends StatefulWidget {
  final InstructType type;

  const _TypeToTablePage({Key? key, required this.type}) : super(key: key);

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
    Account()
      ..username = 'ZH202206'
      ..password = 'INE'
      ..entrusts = [
        (Entrust()
          ..id = 5
          ..price = '2'),
        (Entrust()
          ..id = 6
          ..price = '2'),
      ],
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CommonForm<Account, Entrust>(
      onTapFunc: (Account value) {},
      childValues: (Account value) {
        return value.entrusts ?? [];
      },
      childWidget: [
        FormChildColumn<Entrust>(
          title: const Text(
            '指令合约',
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
            '时间',
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
            '方向',
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
            '价格',
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
            '手数',
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
            '已完成手数',
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
            '状态',
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
            '品种',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          width: 50,
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
            '合约',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
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
            '现价',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
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
            '涨跌幅',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
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
            '涨跌',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
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
            '开盘价',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          builder: (_, v) => Container(
            child: Text(
              '${v.password ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        FormColumn<Account>(
          title: const Text(
            '昨日结算价',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          builder: (_, v) => Container(
            child: Text(
              '${v.password ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        FormColumn<Account>(
          title: const Text(
            '总指令手数',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          builder: (_, v) => Container(
            child: Text(
              '${v.password ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        FormColumn<Account>(
          title: const Text(
            '指令净手数',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          builder: (_, v) => Container(
            child: Text(
              '${v.password ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        FormColumn<Account>(
          title: const Text(
            '进行中手数',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          builder: (_, v) => Container(
            child: Text(
              '${v.password ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        FormColumn<Account>(
          title: const Text(
            '完成手数',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
          builder: (_, v) => Container(
            child: Text(
              '${v.password ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
      values: users,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
