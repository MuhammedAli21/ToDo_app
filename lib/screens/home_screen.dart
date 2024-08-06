import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/settings/settings_screen.dart';
import 'package:todo_app/screens/task_list/task_list.dart';
import 'package:todo_app/screens/task_list/add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget{
  static const String routeName = 'Home_Screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.2,
        title: Text(
            '${AppLocalizations.of(context)!.title}, ${userProvider.currentUser!.name!}',
            style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(onPressed: (){
            provider.taskList = [];
            userProvider.currentUser = null;
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }, icon: Icon(Icons.logout),color: AppColors.whiteColor,)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDarkmode()?
            AppColors.blackDarkColor:
            AppColors.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            currentIndex: screenIndex,
            onTap: (index){
              setState(() {
                screenIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list,),
                  label: AppLocalizations.of(context)!.list),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_outlined,),
                  label: AppLocalizations.of(context)!.setting)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AddTask();
        },
        //we can use stadium
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
              width: 5,
              color: provider.isDarkmode()?
              AppColors.blackDarkColor:
              AppColors.whiteColor
          ),
        ),
        child: Icon(Icons.add,size: 35, color: AppColors.whiteColor,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screenIndex == 0 ? const TaskList() : const SettingsScreen(),
    );
  }

  void AddTask() {
    showModalBottomSheet(
        context: context,
        builder: (context)=> const AddTaskBottomSheet(),
    );
  }
}