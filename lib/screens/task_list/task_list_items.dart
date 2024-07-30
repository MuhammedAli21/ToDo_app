import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';

import '../../data_classes/task.dart';
import '../../provider/app_config_provider.dart';

class TaskListItems extends StatelessWidget {
  Task task;
  TaskListItems({required this.task});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: provider.isDarkmode()?
            AppColors.blackDarkColor:
            Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(12),
            color: AppColors.blueColor,
            height: MediaQuery.of(context).size.height*0.1,
            width: 4,

          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.blueColor,
              ),
              ),
              Text(
                  task.description,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: provider.isDarkmode()?
                  AppColors.whiteColor:
                  AppColors.blackColor,)
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01,
            horizontal: MediaQuery.of(context).size.height*0.03,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.blueColor,
            ),
            child: Icon(
              Icons.check,
              color: AppColors.whiteColor,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
