import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transaction_client/global/global.dart';
import 'package:transaction_client/global/setting.dart';
import 'package:transaction_client/utils/array_helper.dart';
import 'package:native_context_menu/native_context_menu.dart' as native;
import 'package:transaction_client/utils/lock.dart' as self_lock;
import 'package:transaction_client/utils/log_utils.dart';
import 'package:transaction_client/widget/management/common/function_util.dart';

part '_child_row.dart';

FormColumn<T> buildTextFormColumn<T>(
    {required Widget title, required String text(T value)}) {
  return FormColumn<T>(
      title: title, builder: (_, T value) => Text(text(value)));
}

FormColumn<T> buildButtonFormColumn<T>(
    {required Widget title, required String text(T value), InFunc<T>? onTap}) {
  return FormColumn<T>(
    title: title,
    builder: (_, T value) => ElevatedButton(
      onPressed: onTap == null
          ? null
          : () {
              onTap(value);
            },
      child: Text(text(value)),
    ),
  );
}

FormColumn<T> buildIconButtonFormColumn<T>(
    {required Widget title, IconData? icon, InFunc<T>? onTap}) {
  return FormColumn<T>(
      title: title,
      builder: (_, T value) => IconButton(
            icon: Icon(icon),
            onPressed: onTap == null
                ? null
                : () {
                    onTap(value);
                  },
          ));
}

/// self methods
/// [ColorFunc] 用于选中状态下的column，
/// [WidgetBuilderFunc] builder新子类
/// [TapCallBack] 点击的回调
/// [DragCallBack] 拖拽的回调
typedef ColorFunc<T> = MaterialAccentColor? Function(T value);
typedef WidgetBuilderFunc<T> = Widget Function(BuildContext context, T value);
typedef ListWidgetBuilder<T> = List<Widget> Function(
    BuildContext context, T value);
typedef TapCallBack<T> = void Function(T value);
typedef DragCallBack<T> = void Function(T value, int index);

class FormColumn<T> {
  final Widget title;
  final double? width;
  final ColorFunc<T>? color;
  final Widget? extraBuilder;
  final WidgetBuilderFunc<T> builder;

  FormColumn(
      {required this.title,
      required this.builder,
      this.width,
      this.color,
      this.extraBuilder});
}

class FormChildColumn<T> {
  final Widget title;
  final double? width;
  final WidgetBuilderFunc<T> builder;

  FormChildColumn({
    required this.title,
    required this.builder,
    this.width,
  });
}

/// 点击的回调方法[onTapFunc]
///
///
/// 拖拽的回调方法[onDragFunc]，按需选择是否实现
/// [value]当前的值，[index]拖拽到当前位置的索引
///
/// 鼠标右键的回调方法[onMouseEvent]
/// [event]获取鼠标位置 [index]获取当前点击的索引
/// Future<void> onMouseEvent(PointerDownEvent event, int index) async {
///        Log.info(event);
///        Log.info(index);
///  }
///

class CommonForm<T, D> extends StatefulWidget {
  final List<FormColumn<T>> columns;
  final List<FormChildColumn<D>>? childWidget;
  final List<T> values;
  final List<D> Function(T value)? childValues;
  final bool canDrag;
  final bool showExtra;
  final TapCallBack<T>? onTapFunc; //点击回调
  final DragCallBack<T>? onDragFunc; //拖拽后的回调
  final double? height;
  final Color? titleColor;
  final Color? formColor;

  /// 选中反馈
  final bool showSelectItem;

  final RightMenuFunc? rightMenuFunc; // 鼠标右键方法

  const CommonForm(
      {Key? key,
      required this.columns,
      required this.values,
      this.childValues,
      this.canDrag = false,
      this.showExtra = false,
      this.onDragFunc,
      this.childWidget,
      this.onTapFunc,
      this.titleColor,
      this.rightMenuFunc,
      this.formColor,
      this.showSelectItem = false,
      this.height})
      : super(key: key);

  @override
  _CommonFormState<T, D> createState() => _CommonFormState<T, D>();
}

///
/// 通过[StreamBuilder]和[StreamController]实现列的拖拽。
/// 每一次拖拽触发一次[StreamController.sink]，
/// 并通过widget生态的[didUpdateWidget]进行更新，使用[RepaintBoundary]优化组件
///

class _CommonFormState<T, D> extends State<CommonForm<T, D>> {
  ScrollController hController = ScrollController();
  ScrollController vController = ScrollController();

  bool shouldReact = false;
  int onSelectHash = -1;
  List<int> hashcodes = [];

  ///选中item的hash值

  final StreamController<List<FormColumn<T>>> controller =
      StreamController<List<FormColumn<T>>>();
  List<FormColumn<T>> columns = <FormColumn<T>>[];

  /// 拖拽锁
  final self_lock.Lock _lock = self_lock.Lock();

  /// 子表
  bool isShowChild = false;

  @override
  void initState() {
    super.initState();
    columns = widget.columns;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant CommonForm<T, D> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      columns = widget.columns;
      controller.sink.add(columns);
      setState(() {});
    }
  }

  Widget buildTitleRow(List<FormColumn<T>> formList) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.canDrag
          ? formList
              .map((e) => LongPressDraggable(
                  data: e,
                  delay: const Duration(milliseconds: 300),
                  feedback: warpWidget(
                      child: e.title, width: e.width, color: widget.titleColor),
                  child: DragTarget<FormColumn<T>>(
                    onAccept: (data) {
                      final index = columns.indexOf(e);
                      setState(() {
                        columns.remove(data);
                        columns.insert(index, data);
                        controller.sink.add(columns);
                      });
                    },
                    builder: (context, data, rejects) {
                      return warpWidget(
                          child: e.title,
                          width: e.width,
                          color: widget.titleColor);
                    },
                  )))
              .toList(growable: false)
          : formList
              .map(
                (e) => warpWidget(
                    child: e.title, width: e.width, color: widget.titleColor),
              )
              .toList(growable: false),
    );
  }

  ///可拖拽
  Widget buildDragTitleRow(int index) {
    return LongPressDraggable(
      data: index,
      delay: const Duration(milliseconds: 200),
      feedback: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.4, color: Colors.red.shade50),
            color: Colors.red.shade50),
        child: buildRow(ArrayHelper.get(widget.values, index) as T),
      ),
      child: DragTarget<int>(
        onAccept: (data) {
          final temp = widget.values[data];
          setState(() {
            widget.values.remove(temp);
            widget.values.insert(index, temp);
          });
          widget.onDragFunc?.call(temp, index);
        },
        //绘制widget
        builder: (context, data, rejects) {
          return buildRow(ArrayHelper.get(widget.values, index)!,
              color: widget.formColor);
        },
      ),
      onDragStarted: () {
        _lock.lock();
      },
      onDragCompleted: () {
        _lock.unlock();
      },
    );
  }

  ///实现table的每一行
  Widget buildRow(T value, {Color? color}) {
    List<D> childValues = [];
    if (widget.childValues != null) {
      childValues = widget.childValues!.call(value);
    }
    return Listener(
      onPointerDown: (e) {
        shouldReact = e.kind == PointerDeviceKind.mouse &&
            e.buttons == kSecondaryMouseButton;
      },
      onPointerUp: (e) async {
        if (!shouldReact) return;
        shouldReact = false;

        final position = Offset(
          e.position.dx + Offset.zero.dx,
          e.position.dy + Offset.zero.dy,
        );

        final selectedItem = await native.showContextMenu(
          native.ShowMenuArgs(
            MediaQuery.of(context).devicePixelRatio,
            position,
            widget.rightMenuFunc?.menuItems ?? [],
          ),
        );

        if (selectedItem != null) {
          widget.rightMenuFunc?.onItemSelected
              ?.call(selectedItem, widget.values.indexOf(value));
        }
      },
      child: Container(
        decoration: BoxDecoration(color: color),
        child: GestureDetector(
          onTap: () {
            if (onSelectHash != value.hashCode) {
              onSelectHash = value.hashCode ?? -1;
            } else {
              onSelectHash = -1;
            }
            if (!_lock.isUsing()) {
              widget.onTapFunc?.call(value);
            }
            if (childValues.isNotEmpty && widget.childWidget != null) {
              if (!hashcodes.contains(value.hashCode)) {
                hashcodes.add(value.hashCode);
              } else {
                hashcodes.remove(value.hashCode);
              }
            }
            setState(() {});
          },
          child: widget.childWidget != null
              ? Column(
                  children: [
                    Row(
                      children: widget.columns
                          .map((e) => warpWidget(
                              child: e.builder(context, value),
                              color: widget.showSelectItem == true &&
                                      value.hashCode == onSelectHash
                                  ? Colors.blue.shade50
                                  : e.color?.call(value),
                              width: e.width))
                          .toList(growable: false),
                    ),
                    if (hashcodes.contains(value.hashCode))
                      _ChildWidget<D>(
                        key: Key(value.hashCode.toString()),
                        children: widget.childWidget!,
                        values: childValues,
                      ),
                  ],
                )
              : Row(
                  children: widget.columns
                      .map((e) => warpWidget(
                          child: e.builder(context, value),
                          color: value.hashCode == onSelectHash
                              ? Colors.blue.shade50
                              : e.color?.call(value),
                          width: e.width))
                      .toList(growable: false),
                ),
        ),
      ),
    );
  }

  Widget warpWidget({required Widget child, Color? color, double? width}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: const Color(0xE6797979)),
          color: color),
      height: 26,
      width: width ?? 125,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: RepaintBoundary(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (widget.canDrag == true) {
      for (int x = 0; x < widget.values.length; x++) {
        children.add(buildDragTitleRow(x));
      }
    } else {
      children.addAll(
          widget.values.map((e) => buildRow(e, color: widget.formColor)));
    }
    if (widget.showExtra == true) {
      children.add(_extraRow(color: widget.formColor));
    }

    return StreamBuilder<List<FormColumn<T>>>(
      stream: controller.stream,
      initialData: columns,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return widget.height != null
            ? RepaintBoundary(
                child: Scrollbar(
                  controller: hController,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: hController,
                    child: SizedBox(
                      height: widget.height,
                      child: Column(
                        children: [
                          buildTitleRow(snapshot.data as List<FormColumn<T>>),
                          Expanded(
                            child: Scrollbar(
                              controller: vController,
                              child: SingleChildScrollView(
                                controller: vController,
                                child: Column(
                                  children: children,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : RepaintBoundary(
                child: Scrollbar(
                  controller: hController,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: hController,
                    child: Column(
                      children: [
                        buildTitleRow(snapshot.data as List<FormColumn<T>>),
                        Scrollbar(
                          controller: vController,
                          child: SingleChildScrollView(
                            controller: vController,
                            child: Column(
                              children: children,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget _extraRow({Color? color}) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Row(
        children: widget.columns
            .map((e) => warpWidget(
                child: e.extraBuilder ?? Container(), width: e.width))
            .toList(growable: false),
      ),
    );
  }
}

class RightMenuFunc {
  List<native.MenuItem>? menuItems;
  void Function(native.MenuItem item, int index)? onItemSelected;

  RightMenuFunc({this.menuItems, this.onItemSelected});
}
