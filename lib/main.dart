import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/theme_data.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/screens/settings/settings.dart';
import 'package:todo_app/screens/task_list/task_list.dart';

void main(){
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: Myapp()));
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routName ,
      routes: {
        HomeScreen.routName : (context) => HomeScreen(),
        Settings.routName : (context) => Settings(),
        TaskList.routName : (context) => TaskList(),
      },
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyThemeData.lightColor,
      themeMode: provider.appTheme,
      darkTheme: MyThemeData.darkColor,
    );
  }
}