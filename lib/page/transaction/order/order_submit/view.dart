import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/page/transaction/order/order_modal.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/common_input/text_input_number.dart';
import 'package:transaction_client/widget/drop_menu/overlay_field.dart';
import 'package:transaction_client/widget/search_field.dart';

import 'logic.dart';
import 'state.dart';

class OrderSubmitPage extends StatefulWidget {
  bool? showTitle;

  OrderSubmitPage({super.key, this.showTitle});

  @override
  _OrderSubmitPageState createState() => _OrderSubmitPageState();
}

class _OrderSubmitPageState extends State<OrderSubmitPage> {
  final OrderSubmitLogic logic = Get.put(OrderSubmitLogic());
  final OrderSubmitState state = Get.find<OrderSubmitLogic>().state;

  final List<String> _suggestions = [
    'United States',
    'Germany',
    'Washington',
    'Paris',
    'Jakarta',
    'Australia',
    'India',
    'Czech Republic',
    'Lorem Ipsum',
  ];
  final List<String> _statesOfIndia = [
    'Andhra Pradesh',
    'Assam',
    'Arunachal Pradesh',
    'Bihar',
    'Goa',
    'Gujarat',
    'Jammu and Kashmir',
    'Jharkhand',
    'West Bengal',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Orissa',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Tripura',
    'Uttaranchal',
    'Uttar Pradesh',
    'Haryana',
    'Himachal Pradesh',
    'Chhattisgarh'
  ];

  final _searchController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    state.isShowBar.value = widget.showTitle ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: state.isShowBar.value
            ? AppBar(
                title: const Text('下单'),
              )
            : null,
        body: SingleChildScrollView(
          controller: _controller,
          child: Container(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
              child: Form(
                key: state.formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: screenUtil.adaptive(30),
                        right: screenUtil.adaptive(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            '合约',
                                            style: TextStyle(),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Order.Modal(context);
                                            },
                                            child: const Icon(
                                              Icons.search,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          state.readOnly.value =
                                              !state.readOnly.value;
                                        },
                                        child: Icon(
                                          state.readOnly.value
                                              ? Icons.lock
                                              : Icons.lock_open,
                                          size: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: SearchField(
                                    suggestions: _suggestions,
                                    controller: _searchController,
                                    readOnly: state.readOnly.value,
                                    hint: '选择合约',
                                    searchAlignVertical:
                                        TextAlignVertical.bottom,
                                    initialValue: _suggestions[2],
                                    searchInputDecoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    maxSuggestionsInViewPort: 4,
                                    itemHeight: screenUtil.adaptive(30),
                                    onTap: (x) {
                                      print(
                                          'selected =$x ${_searchController.text}');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenUtil.adaptive(20),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    '手数',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  child: TextInputNumberUpDown(
                                    height: screenUtil.adaptive(30),
                                    focusNode: FocusNode(),
                                    key: const Key('Hand'),
                                    onSave: (String? value) {},
                                    rulesFunc: RulesFunc(
                                      upRule: (controller) {
                                        if (controller.text.isEmpty == true) {
                                          controller.text = '1';
                                        } else {
                                          controller.text =
                                              (int.tryParse(controller.text)! +
                                                      1)
                                                  .toString();
                                        }
                                      },
                                      downRule: (controller) {
                                        if (controller.text.isEmpty == true) {
                                          controller.text = '0';
                                        } else if (int.tryParse(
                                                controller.text)! >
                                            0) {
                                          controller.text =
                                              (int.tryParse(controller.text)! -
                                                      1)
                                                  .toString();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: screenUtil.adaptive(30),
                        right: screenUtil.adaptive(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    '价格',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  child: TextInputNumberUpDown(
                                    focusNode: FocusNode(),
                                    key: const Key('Price'),
                                    height: screenUtil.adaptive(30),
                                    onSave: (String? value) {},
                                    rulesFunc: RulesFunc(
                                      upRule: (controller) {
                                        if (controller.text.isEmpty == true) {
                                          controller.text = '1';
                                        } else {
                                          controller.text =
                                              (int.tryParse(controller.text)! +
                                                      1)
                                                  .toString();
                                        }
                                      },
                                      downRule: (controller) {
                                        if (controller.text.isEmpty == true) {
                                          controller.text = '0';
                                        } else if (int.tryParse(
                                                controller.text)! >
                                            0) {
                                          controller.text =
                                              (int.tryParse(controller.text)! -
                                                      1)
                                                  .toString();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenUtil.adaptive(10),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    '方向',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  height: screenUtil.adaptive(30),
                                  alignment: Alignment.centerLeft,
                                  child: Obx(
                                    () => OverlayField<int>(
                                      key: const Key('Side'),
                                      maxHeight: 40,
                                      initValue: '${state.side.value}',
                                      lists: state.sides,
                                      textStyle: const TextStyle(fontSize: 14),
                                      onChange: (int e) {
                                        state.side.value = e;
                                      },
                                      child: (int e) {
                                        return Container(
                                          height: 20,
                                          alignment: Alignment.centerLeft,
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: Text('$e'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: screenUtil.adaptive(30),
                        right: screenUtil.adaptive(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    '开平',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  height: screenUtil.adaptive(30),
                                  alignment: Alignment.centerLeft,
                                  child: Obx(
                                    () => OverlayField<int>(
                                      key: const Key('OpenFlag'),
                                      maxHeight: 100,
                                      initValue: '${state.openFlag.value}',
                                      lists: state.openFlags,
                                      textStyle: const TextStyle(fontSize: 14),
                                      onChange: (int e) {
                                        state.openFlag.value = e;
                                      },
                                      child: (int e) {
                                        return Container(
                                          height: 20,
                                          alignment: Alignment.centerLeft,
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: Text('$e'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    '投保',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  height: screenUtil.adaptive(30),
                                  alignment: Alignment.centerLeft,
                                  child: Obx(
                                        () => OverlayField<int>(
                                      key: const Key('HedgeFlag'),
                                      maxHeight: 100,
                                      initValue: '${state.hedgeFlag.value}',
                                      lists: state.hedgeFlags,
                                      textStyle: const TextStyle(fontSize: 14),
                                      onChange: (int e) {
                                        state.hedgeFlag.value = e;
                                      },
                                      child: (int e) {
                                        return Container(
                                          height: 20,
                                          alignment: Alignment.centerLeft,
                                          margin:
                                          const EdgeInsets.only(left: 4),
                                          child: Text('$e'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: screenUtil.adaptive(30),
                        right: screenUtil.adaptive(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    '类型',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  height: screenUtil.adaptive(30),
                                  alignment: Alignment.centerLeft,
                                  child: Obx(
                                    () => OverlayField<int>(
                                      key: const Key('OrdType'),
                                      initValue: '${state.ordType.value}',
                                      lists: state.ordTypes,
                                      textStyle: const TextStyle(fontSize: 14),
                                      onChange: (int e) {
                                        state.ordType.value = e;
                                      },
                                      child: (int e) {
                                        return Container(
                                          height: 20,
                                          alignment: Alignment.centerLeft,
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: Text('$e'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: screenUtil.adaptive(15),
                                      bottom: screenUtil.adaptive(10)),
                                  child: const Text(
                                    'TIF类',
                                    style: TextStyle(),
                                  ),
                                ),
                                Container(
                                  height: screenUtil.adaptive(30),
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => OverlayField<int>(
                                      key: const Key('Tif'),
                                      maxHeight: 100,
                                      initValue: '${state.tif.value}',
                                      lists: state.tifs,
                                      textStyle: const TextStyle(fontSize: 14),
                                      onChange: (int e) {
                                        state.tif.value = e;
                                      },
                                      child: (int e) {
                                        return Container(
                                          height: 20,
                                          alignment: Alignment.centerLeft,
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: Text('$e'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        logic.onSubmit();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: screenUtil.adaptive(20),
                          top: screenUtil.adaptive(20),
                        ),
                        decoration: BoxDecoration(color: Setting.orderSubmitColor),
                        padding: EdgeInsets.only(
                            top: screenUtil.adaptive(5),
                            bottom: screenUtil.adaptive(5),
                            right: screenUtil.adaptive(100),
                            left: screenUtil.adaptive(100)),
                        child: const Text('下单'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<OrderSubmitLogic>();
    super.dispose();
  }
}
