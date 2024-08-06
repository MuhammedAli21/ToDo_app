
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/data_classes/theme_data.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/screens/settings/settings_screen.dart';
import 'package:todo_app/screens/task_list/task_list.dart';

import 'firebase_options.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);

  //await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AppConfigProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
  ],
      child: const Myapp()
  ));

}

class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) =>  HomeScreen(),
        SettingsScreen.routeName : (context) =>  SettingsScreen(),
        TaskList.routeName : (context) =>  TaskList(),
        RegisterScreen.routeName : (context) =>  RegisterScreen(),
        LoginScreen.routeName : (context) =>  LoginScreen(),
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