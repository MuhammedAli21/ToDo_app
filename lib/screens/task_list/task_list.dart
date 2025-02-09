import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/screens/task_list/task_list_items.dart';

import '../../provider/app_config_provider.dart';
import '../../provider/user_provider.dart';

class TaskList extends StatefulWidget {
  static const String routeName = "List_screen";

  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var  userProvider = Provider.of<UserProvider>(context);

    if(provider.taskList.isEmpty){
      provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
    }

    return  Column(
        children: [
          EasyDateTimeLine(
            locale: provider.appLanguage,
            initialDate: provider.selectDate,
            onDateChange: (selectedDate) {
              provider.changeSelectDate(selectedDate,userProvider.currentUser!.id!);
              //`selectedDate` the new date selected.
            },
            activeColor: AppColors.blueColor,
            headerProps: EasyHeaderProps(
             monthPickerType: MonthPickerType.switcher,
              dateFormatter: const DateFormatter.fullDateDMonthAsStrY(),
              selectedDateStyle: TextStyle(
                color: provider.isDarkmode()?
                    AppColors.whiteColor:
                    AppColors.blackColor
              )
            ),
            dayProps: EasyDayProps(
              height: 56.0,
              width: 56.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: provider.isDarkmode() ?
                      AppColors.blackDarkColor:
                      Colors.white,
                ),
                dayNumStyle: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: const DayStyle(
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
                  return TaskListItems(task: provider.taskList[index],);
                },
              itemCount: provider.taskList.length,
                ),
          )
        ],
    );
  }

}
