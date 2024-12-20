import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/shared_pref.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final sharedPref = SharedPref();

  Future<void> appStarted()async{

    try{

      final uid = await sharedPref.getUid();


      if (uid !=null){
        emit(Authenticated(uid));
      }else{
        emit(UnAuthenticated());
      }


    }catch(_){
      emit(UnAuthenticated());
    }






  }

 //jab ham application mein loggin karenge tu is id  ko store karenge 
  Future<void> loggedIn(String uid)async{
    sharedPref.setUid(uid);
    emit(Authenticated(uid));
  }

  Future<void> loggedOut()async{
    sharedPref.setUid("");
    emit(UnAuthenticated());
  }

}