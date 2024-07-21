import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routName ,
      routes: {
        HomeScreen.routName : (context) => HomeScreen(),
      },
    );
  }
}