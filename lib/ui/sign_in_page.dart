



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:noteapp/cubit/auth/auth_cubit.dart';
import 'package:noteapp/router/page_const.dart';
import 'package:noteapp/ui/home_page.dart';
import 'package:noteapp/ui/widgets/custom_text_field.dart';

import '../cubit/credential/credential_cubit.dart';
import '../models/user_model.dart';
import 'widgets/common.dart';
import 'widgets/custom_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit,CredentialState>(
        listener: (context,credentialState){

          if (credentialState is CredentialSuccess){
            context.read<AuthCubit>().loggedIn(credentialState.user.uid!);
          }

          if (credentialState is CredentialFailure){
            showSnackBarMessage(credentialState.errorMessage,context);
          }


        },
        builder: (context,credentialState){


          if (credentialState is CredentialLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (credentialState is CredentialSuccess){

            return BlocBuilder<AuthCubit,AuthState>(builder: (context,authState){


              if (authState is Authenticated){
                return HomePage(uid:authState.uid);
              }else{

                return _bodyWidget();
              }

            });

          }


          return _bodyWidget();
        },
      ),
    );
  }


  Widget _bodyWidget(){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In"),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Note App",style: TextStyle(fontSize: 50),)),
              SizedBox(height: 50,),
              CustomTextField(
                hint: "Email",
                controller: _emailController,
              ),
              SizedBox(height: 20,),
              CustomTextField(
                hint: "Password",
                controller: _passwordController,
                obsecureText: true,
              ),
              SizedBox(height: 20,),
              CustomButton(title: "Login",onTap: _submitSignIn),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Don't have an account"),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
                    },
                    child: Text(
                      " Sign Up",
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitSignIn() {

    if (_emailController.text.isEmpty){
      showSnackBarMessage("Enter Email", context);
      return;
    }

    if (_passwordController.text.isEmpty){
      showSnackBarMessage("Enter Password", context);
      return;
    }

    context.read<CredentialCubit>().signIn(UserModel(
      email: _emailController.text,
      password: _passwordController.text,
    ));

  }
}