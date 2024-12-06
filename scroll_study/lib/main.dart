import 'package:flutter/material.dart';
import 'package:scroll_study/win_calendar_month_view.dart';

void main() {
  runApp(const APage());
}

class APage extends StatelessWidget {
  const APage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: WinCalendarMonthWidget(
          year: 2024,
          month: 12,
          checkedDays: [],
          didGetHeight: (value) {},
          aPHeight: 240,
        ),
      ),
    );
  }
}
