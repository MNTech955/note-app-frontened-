import 'package:flutter/material.dart';
import 'package:noteapp/cubit/auth/auth_cubit.dart';
import 'package:noteapp/cubit/credential/credential_cubit.dart';
import 'package:noteapp/cubit/note/note_cubit.dart';
import 'package:noteapp/cubit/user/user_cubit.dart';
import 'package:noteapp/router/on_generate_route.dart';
import 'package:noteapp/ui/home_page.dart';

import 'package:noteapp/ui/sign_in_page.dart';

//import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          //jab ham application ko open karenge tu hai method hamre pass call huga and iski help se ham 
          //check karenge ke user login hai ke nai 
          create: (context) => AuthCubit()..appStarted(),
        ),
        BlocProvider(
          create: (context) => CredentialCubit(),
        ),
         BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
         BlocProvider<NoteCubit>(
          create: (context) => NoteCubit(),
        ),
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: OnGenerateRoute.route,
      routes: {
        "/":(context) {
             return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                if (authState.uid == "") {
                  return SignInPage();
                } else {
                  return HomePage(uid: authState.uid,);
                }
              } else {
                return SignInPage();
              }
                }
             );
        
        }
      },
    )
    );
  }
}

