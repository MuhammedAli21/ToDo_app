import 'package:flutter/material.dart';
import 'package:todo_app/data_classes/app_colors.dart';


typedef MyValidator = String? Function(String?);
class CustomTextFormFiled extends StatelessWidget {

  String lable;
  MyValidator validator;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText ;


  CustomTextFormFiled({super.key, required this.lable,required this.validator, required this.controller, this.keyboardType = TextInputType.text , this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: AppColors.blueColor,
                width: 2
              )
            ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.blueColor,
                  width: 2
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.redColor,
                  width: 2
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.redColor,
                  width: 2
              )
          ),
          labelText: lable,

        ),
        validator: validator,
        keyboardType: keyboardType ,
        controller : controller,
        obscureText: obscureText,
      ),
    );
  }
}
