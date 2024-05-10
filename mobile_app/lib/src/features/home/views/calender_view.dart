import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
          children: [
        Expanded(
          flex: 1,
        child: SizedBox(
        height: 200,
          width: 300,
          child: TableCalendar(
            shouldFillViewport: true,
            firstDay: DateTime(2020),
            lastDay: DateTime(2021),
            focusedDay: DateTime(2020),
          ),
        ),
      ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 200,
                width: 300,
                child: TableCalendar(
                  shouldFillViewport: true,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2021),
                  focusedDay: DateTime(2020),
                ),
              ),
            ),


      ],
    ),
    );
  }
}
