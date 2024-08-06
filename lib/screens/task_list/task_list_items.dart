import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/user_provider.dart';

import '../../data_classes/task.dart';
import '../../provider/app_config_provider.dart';

import 'edit_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskListItems extends StatefulWidget {
  Task task;
  TaskListItems({super.key, required this.task});

  @override
  State<TaskListItems> createState() => _TaskListItemsState();
}

class _TaskListItemsState extends State<TaskListItems> {
  late AppConfigProvider provider;

  bool click = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.5,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),


          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                print(provider.newTitle);
                print(provider.newDescription);


                editTask();
                FirebaseUtils.deleteTaskFromFireStore(
                    widget.task, userProvider.currentUser!.id!);
              },
              backgroundColor: AppColors.blueColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                //delete task

                FirebaseUtils.deleteTaskFromFireStore(
                    widget.task, userProvider.currentUser!.id!)

                    .then((value) {
                  // print('task deleted successfully');
                  provider.getAllTasksFromFireStore(
                      userProvider.currentUser!.id!);
                })
                    .timeout(const Duration(seconds: 1),
                    onTimeout: () {
                      print('task deleted successfully');
                      provider.getAllTasksFromFireStore(
                          userProvider.currentUser!.id!);
                    });

                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.delete_message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.blueColor,
                    textColor: AppColors.whiteColor,
                    fontSize: 16.0
                );
              },

              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],

        ),

        child: Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: provider.isDarkmode() ?
            AppColors.blackDarkColor :
            Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                color: click == false ? AppColors.greenColor : AppColors
                    .blueColor,
                height: MediaQuery.of(context).size.height * 0.1,
                width: 4,

              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( widget.task.title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      color: click == false ? AppColors.greenColor : AppColors
                          .blueColor,
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,),
                  Text(
                      widget.task.description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: provider.isDarkmode() ?
                        AppColors.whiteColor :
                        AppColors.blackColor,)
                  ),
                ],
              )),
              InkWell(
                onTap: () {
                  click = !click;
                  setState(() {

                  });
                },
                child: click == false ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('DONE!',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                        color: AppColors.greenColor,
                        fontSize: 30
                    ),
                  ),
                ) :


                Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01,
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.blueColor
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                    size: 35,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void editTask() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const EditTask(),
    );
  }
}