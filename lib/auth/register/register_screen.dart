import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_filed.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/data_classes/my_user.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const  String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'Mohamed');

  TextEditingController emailController = TextEditingController(text: 'mohamed12@gmail.com');

  TextEditingController passwordController = TextEditingController(text: '123456789');

  TextEditingController confirmPasswordController = TextEditingController(text: '123456789');

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: AppColors.lightBackGroundColor,
      child: Stack(
        children: [
          Image.asset('assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Register',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.25,),
                    CustomTextFormFiled(lable: 'Username',
                    controller: nameController ,
                      validator: (text){
                      if(text == null || text.trim().isEmpty){
                        return 'please enter username';
                      }
                      return null;
                      },
                    ),
                    CustomTextFormFiled(lable: 'Email',
                    controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'please enter email';
                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid){
                          return 'please enter email';
                        }

                        return null;

                      },
                    ),
                    CustomTextFormFiled(lable: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'please enter password';
                        }
                        if(text.length < 6){
                          return 'Password should be at min 6 chars.';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormFiled(lable: 'Confirm Password',
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.phone,
                      obscureText: true,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'please enter confirmPassword';
                        }
                        if(text != passwordController.text){
                          return "Password doesn't match";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                        register();
                        }, child: Text('Create Account')),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void register() async {

    if(formkey.currentState?.validate() == true){
      //register
      DialogUtils.showLoading(context: context, message: 'Loading');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        MyUser user = MyUser(name: nameController.text, email: emailController.text, id: credential.user?.uid);
        await FirebaseUtils.addUserToFireStore(user);

        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);

        DialogUtils.hideLoading(context);
        print(credential.user?.uid??"");
        DialogUtils.showMessage(
            context: context,
            message: 'register successfully',
            title: 'success',
            posActionName: 'OK',
          posAction: (){Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);}
            );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'The password provided is too weak',title: 'Error',posActionName: 'OK',);
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'The account already exists for that email',title: 'Error',posActionName: 'OK',);
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString());
        print(e);
      }
    }
  }
}
