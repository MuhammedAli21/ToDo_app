import 'package:flutter/material.dart';
import 'package:todo_app/data_classes/app_colors.dart';

class DialogUtils{
  static void showLoading({ required BuildContext context,required String message}){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Padding(padding: EdgeInsets.all(8),
            child: Text(message),
            )
          ],
        ),
      );
      }
    );
  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context ,
    required String message ,
    String title = '' ,
    String? posActionName ,
    Function? posAction ,
    String? negActionName ,
    Function? negAction}){

    List<Widget> actions = [];

    if(posActionName != null ){
      actions.add(TextButton(onPressed: (){

        Navigator.pop(context);
        posAction?.call();
      },
          child: Text(posActionName)));
    }
    if(negActionName != null ){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(message),
            title: Text(title,style : Theme.of(context).textTheme.titleMedium),
            actions: actions,
          );
        }
    );
  }
}