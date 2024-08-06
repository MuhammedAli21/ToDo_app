import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/data_classes/task.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/user_provider.dart';


class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  late AppConfigProvider provider;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(20),
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
                      controller: titleController,
                      style: TextStyle(color: provider.isDarkmode()?AppColors.whiteColor:AppColors.blackDarkColor),
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enter_task_title,
                          hintStyle: TextStyle(
                              color: provider.isDarkmode()?
                              AppColors.grayColor:
                              AppColors.blackDarkColor
                          )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      validator: (text){
                        if(text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_task_title;
                        }
                        else{
                          return null;
                        }
                      },
                      controller: descriptionController,
                      style: TextStyle(color: provider.isDarkmode()?AppColors.whiteColor:AppColors.blackDarkColor),
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
                            editTask();

                          },
                          child: Text(
                            AppLocalizations.of(context)!.edit,
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

  void editTask() {
    if(formKey.currentState?.validate() == true)
    {
      print('test');
      //add Task
      Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate,
      );
      var userProvider = Provider.of<UserProvider>(context,listen: false);
      var provider = Provider.of<AppConfigProvider>(context,listen: false);

      FirebaseUtils.addTaskToFireStore(task,userProvider.currentUser!.id!)
          .then((value){
        print('task added');

        provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
        Navigator.pop(context);})

          .timeout(const Duration(seconds: 2),
          onTimeout: (){
            print('task added');
            provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
            Navigator.pop(context);
          });

  }}

  void showCalender() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:  DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    /* if(date != null){
     selectedDate = date ;
   }*/ // OR

    selectedDate = date ?? selectedDate;
    setState(() {
    });
  }



}
