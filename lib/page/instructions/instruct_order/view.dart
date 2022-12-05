import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transaction_client/global/global.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/utils/screen.dart';
import 'package:transaction_client/widget/common_input/text_input_number.dart';
import 'package:transaction_client/widget/drop_menu/overlay_field.dart';

import 'logic.dart';

class InstructOrderPage extends StatelessWidget {
  final logic = Get.put(InstructOrderLogic());
  final state = Get.find<InstructOrderLogic>().state;

  InstructOrderPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  '合约',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: const Color(0xff797979),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: state.controller,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00ffffff),
                                      width: 0.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00ffffff),
                                      width: 0.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 6),
                                ),

                                /// todo 填合约编码 合约编码用中台得设置都能找到交易所,暂时没中台就先不能手动吧
                                readOnly: true,
                                onSaved: (String? val) {},
                              ),
                            ),
                            /// todo 锁住就不能点击替换合约内容了
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  right: screenUtil.adaptive(5)),
                              child: InkWell(
                                onTap: () {
                                  Global.lock = !Global.lock;
                                },
                                child: Icon(
                                  Global.lock
                                      ? Icons.lock
                                      : Icons.lock_open,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
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
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: const Color(0xff797979),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: TextFormField(
                          controller: state.hands,
                          cursorHeight: 18,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00ffffff),
                                width: 0.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00ffffff),
                                width: 0.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 6),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9]')),
                          ],
                          onSaved: (value) {

                          },
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
              left: 30,
              right: 30,
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
                          controller: state.price,
                          focusNode: FocusNode(),
                          key: const Key('Price'),
                          height: 30,
                          onSave: (String? value) {},
                          rulesFunc: RulesFunc(
                            upRule: (controller) {
                              if (controller.text.isEmpty == true) {
                                controller.text = '1';
                              } else {
                                controller.text =
                                    (int.tryParse(controller.text)! + 1)
                                        .toString();
                              }
                            },
                            downRule: (controller) {
                              if (controller.text.isEmpty == true) {
                                controller.text = '0';
                              } else if (int.tryParse(controller.text)! >
                                  0) {
                                controller.text =
                                    (int.tryParse(controller.text)! - 1)
                                        .toString();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
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
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: Obx(
                              () => OverlayField<String>(
                            key: const Key('Side'),
                            maxHeight: 60,
                            initValue: state.side.value,
                            lists: state.sides,
                            textStyle: const TextStyle(fontSize: 14),
                            onChange: (String e) {
                              state.side.value = e;
                            },
                            child: (String e) {
                              return Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(4),
                                child: Text(e),
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
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
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
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: Obx(
                              () => OverlayField<String>(
                            key: Key(
                                state.positionTypes.hashCode.toString()),
                            maxHeight: 85,
                            initValue: state.positionType.value,
                            lists: state.positionTypes,
                            textStyle: const TextStyle(fontSize: 14),
                            onChange: (String e) {
                              state.positionType.value = e;
                            },
                            child: (String e) {
                              return Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(4),
                                child: Text(e),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
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
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: Obx(
                              () => OverlayField<String>(
                            key:
                            Key(state.insuredTypes.hashCode.toString()),
                            maxHeight: 85,
                            initValue: state.insuredType.value,
                            lists: state.insuredTypes,
                            textStyle: const TextStyle(fontSize: 14),
                            onChange: (String e) {
                              state.insuredType.value = e;
                            },
                            child: (String e) {
                              return Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(4),
                                child: Text(e),
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
              left: 30,
              right: 30,
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
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: Obx(
                              () => OverlayField<String>(
                            key: Key(state.orderTypes.hashCode.toString()),
                            initValue: state.orderType.value,
                            lists: state.orderTypes,
                            maxHeight: 85,
                            textStyle: const TextStyle(fontSize: 14),
                            onChange: (String e) {
                              state.orderType.value = e;
                            },
                            child: (String e) {
                              return Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(4),
                                child: Text('$e'),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
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
                        height: 30,
                        alignment: Alignment.center,
                        child: Obx(
                              () => OverlayField<String>(
                            key: Key(state.tifs.hashCode.toString()),
                            maxHeight: 85,
                            initValue: state.tif.value,
                            lists: state.tifs,
                            textStyle: const TextStyle(fontSize: 14),
                            onChange: (String e) {
                              state.tif.value = e;
                            },
                            child: (String e) {
                              return Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(4),
                                child: Text(e),
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
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {

            },
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Setting.orderSubmitColor),
              padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 100, left: 100),
              ),
            ),
            child: const Text(
              '下单',
              style: TextStyle(
                color: Color(0xff333333),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
