import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WinCalendarMonthWidget extends StatefulWidget {
  final int year;
  final int month;
  final List<int> checkedDays;

  final double aPHeight;

  Function(double) didGetHeight;

  WinCalendarMonthWidget(
      {super.key, required this.year, required this.month, required this.checkedDays,required this.didGetHeight, required this.aPHeight});

  @override
  State<WinCalendarMonthWidget> createState() => _WinCalendarMonthWidgetState();
}

class _WinCalendarMonthWidgetState extends State<WinCalendarMonthWidget> {

 // 用户打卡的天数
  final GlobalKey gridKey = GlobalKey(debugLabel: 'gridKey');

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration){
      print('minScrollExtent::${_scrollController.position.minScrollExtent}');
      print('aPHeight::${widget.aPHeight + _scrollController.position.maxScrollExtent}');
      widget.didGetHeight.call(widget.aPHeight + _scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {

    // 获取当前月份的天数
    int totalDaysInMonth = _getTotalDaysInMonth(widget.year, widget.month);
    // 获取当前月的第一天是星期几
    int firstWeekday = _getFirstWeekdayOfMonth(widget.year, widget.month);

    List<Widget> dayWidgets = [];

    // 添加日期
    dayWidgets.add(_makeDaysWidget('日'));
    dayWidgets.add(_makeDaysWidget('一'));
    dayWidgets.add(_makeDaysWidget('二'));
    dayWidgets.add(_makeDaysWidget('三'));
    dayWidgets.add(_makeDaysWidget('四'));
    dayWidgets.add(_makeDaysWidget('五'));
    dayWidgets.add(_makeDaysWidget('六'));

    // 计算每一行的天数，7天为一行,注意，一星期是从周日开始
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(Container()); // 空白单元格
    }

    // 添加实际的日期
    for (int i = 1; i <= totalDaysInMonth; i++) {
      bool isChecked = widget.checkedDays.contains(i);
      dayWidgets.add(
        _buildDayTile(i, isChecked),
      );
    }

    // 补齐空的单元格，确保总数是7的倍数
    int totalCells = dayWidgets.length;
    while (totalCells % 7 != 0) {
      dayWidgets.add(Container()); // 空白单元格
      totalCells++;
    }

    return GridView.builder(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(), // 禁止滚动
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 每行显示7个日期
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        return dayWidgets[index];
      },
    );
  }

  _makeDaysWidget(String day){
    return Center(child: Text(day,style: TextStyle(
      color: Color(0xFF787979),
      fontSize: 36 / 3,
      fontWeight: FontWeight.w500,
    ),));
  }

  // 获取当前月的总天数
  int _getTotalDaysInMonth(int year, int month) {
    // 如果是 12 月，下个月为下一年的 1 月
    DateTime firstDayOfNextMonth = (month == 12)
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    // 当月的最后一天是下个月第一天的前一天
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }

  // 获取当前月第一天是星期几
  int _getFirstWeekdayOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.weekday % 7; // 1是星期一，7是星期天，转换为 0-6
  }

  // 构建每一天的单元格
  Widget _buildDayTile(int day, bool isChecked) {
    return Container(
      decoration: BoxDecoration(
        color: isChecked ? Color(0xFFFA5F32) : Colors.green, // 根据打卡状态设置背景色
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            color: isChecked ? Colors.white : Colors.black,
            fontSize: 42 / 3,
          ),
        ),
      ),
    );
  }

  _didGetCalendarLayout(){
    final RenderBox? renderBox = gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      // 获取GridView的大小
      final size = renderBox.size;
      print("GridView Height: ${size.height}");
    } else {
      print("Failed to get GridView size.");
    }
  }
}