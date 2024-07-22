import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/screens/task_list/task_list_items.dart';

class TaskList extends StatelessWidget {
  static const String routName = "List_screen";

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            activeColor: AppColors.blueColor,
            headerProps: const EasyHeaderProps(
              dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
            ),
            dayProps: const EasyDayProps(
              height: 56.0,
              width: 56.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context , index){
                  return TaskListItems();
                },
              itemCount: 30,
                ),
          )
        ],
    );
  }
}
