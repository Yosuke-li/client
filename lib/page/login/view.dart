import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0x50999999)))),
            padding: const EdgeInsets.only(right: 10, left: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '期货交易系统',
                    style: TextStyle(
                      color: Color(0x95999999),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    logic.closeWindowsManager();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
          Container(
            width: 500,
            height: 300,
            child: Form(
              key: state.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '登陆期货交易系统',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: 400.0,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 5, //阴影范围
                      //     spreadRadius: 0.9, //阴影浓度
                      //     color: Colors.grey.withOpacity(0.2), //阴影颜色
                      //   ),
                      // ],
                    ),
                    child: TextFormField(
                      controller: state.nameController,
                      decoration: InputDecoration(
                        labelText: '请输入用户名',
                        prefixIcon: const Icon(
                          IconData(0xe8c8, fontFamily: 'AliIcons'),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                      onSaved: (String? val) {
                        state.nameController.text = val!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 400.0,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 5, //阴影范围
                      //     spreadRadius: 0.9, //阴影浓度
                      //     color: Colors.grey.withOpacity(0.2), //阴影颜色
                      //   ),
                      // ],
                    ),
                    child: TextFormField(
                      controller: state.passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: '请输入密码',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                      onSaved: (String? val) {
                        state.passController.text = val!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 400,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Obx(
                          () => Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              value: state.isSave.value,
                              onChanged: (bool? value) {
                                logic.change();
                              },
                            ),
                          ),
                        ),
                        const Text(
                          "记住密码",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logic.login();
                    },
                    child: Container(
                      width: 350,
                      height: 35,
                      alignment: Alignment.center,
                      child: const Text(
                        "登录",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
