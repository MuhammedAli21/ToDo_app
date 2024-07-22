import 'package:flutter/material.dart';
import 'package:todo_app/data_classes/app_colors.dart';

class TaskListItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
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
              Text('Title',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.blueColor,
              ),
              ),
              Text('Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blackColor,)
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
