import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/data_classes/task.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/app_config_provider.dart';


class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
var formKey = GlobalKey<FormState>();
var selectedDate = DateTime.now();
var title = '';
var description = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_tak,
              style:Theme.of(context).textTheme.titleMedium,
            ),
            Form(
              key: formKey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (text){
                    if(text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_task_title;
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (text){
                    title = text;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task_title,
                    hintStyle: TextStyle(
                      color: provider.isDarkmode()?
                          AppColors.grayColor:
                          AppColors.blackDarkColor
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (text){
                    if(text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_task_Description;
                      }
                    else{
                      return null;
                    }
                  },
                  onChanged: (text){
                    description = text;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task_description,
                      hintStyle: TextStyle(
                          color: provider.isDarkmode()?
                          AppColors.grayColor:
                          AppColors.blackDarkColor
                      )
                  ),
                  maxLines: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.select_date,style: Theme.of(context).textTheme.titleSmall,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: (){
                      showCalender();
                    },
                    child: Text(
                      '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor
                    ),
                      onPressed: (){
                      addNewTask();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.add,
                        style: Theme.of(context).textTheme.titleLarge,)
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  void addNewTask() {
    print('this is print bottom');
    if(formKey.currentState?.validate() == null)
      {
        //add Task
        Task task = Task(
            title: title,
            description: description,
            dateTime: selectedDate,
        );
        FirebaseUtils.addTaskToFireStore(task).timeout(Duration(seconds: 2),
            onTimeout: (){print('task added');});
      }
  }

  void showCalender() async {
   var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:  DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
  /* if(date != null){
     selectedDate = date ;
   }*/ // OR

    selectedDate = date ?? selectedDate;
    setState(() {
    });
  }
}
