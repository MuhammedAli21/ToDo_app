import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_filed.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/screens/home_screen.dart';

import '../../provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const  String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: 'mohamed12@gmail.com');

  TextEditingController passwordController = TextEditingController(text: '123456789');

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
              title: Text('Login',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Welcome Back',
                      style: Theme.of(context).textTheme.titleMedium,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                        login();
                      }, child: Text('Login')),
                    ),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    }, child: Text('Or Create New Account'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void login() async {
    if(formkey.currentState?.validate() == true){
      //login
      //todo: loading
      DialogUtils.showLoading(context: context, message: 'Loading');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var user =  await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? '');
        if(user == null){return;}

        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);

        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: 'Login successfully',
            title: 'success',
            posActionName: 'OK',
            posAction: (){Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);});
        print(credential.user?.uid??"");
      }on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(context: context,
              message: 'No user found for that email',
              title: 'Error');
          print('No user found for that email.');
        }
        if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(context: context,
              message: 'Network Error (such as timeout, interrupted connection or unreachable host) has occurred',
              title: 'Error',
            posActionName: 'ok',
          );
          print('No user found for that email.');
        }
      }catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString());
        print(e.toString());
      }
    }
  }
}
