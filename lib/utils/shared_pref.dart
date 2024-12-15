


import 'package:shared_preferences/shared_preferences.dart';


const _currentUserId = "currentUserId";

class SharedPref{


//jab ham user ko login and signUp karenege tu is method ke through ham used ki uid ko store karenge sharedPref mein 
  void setUid(String uid)async{
    final pref =await SharedPreferences.getInstance();
    //cashed ke andar hai value store hugi
    pref.setString(_currentUserId, uid); 
  }

  Future<String?> getUid() async{
    final pref =await SharedPreferences.getInstance();

    return pref.getString(_currentUserId);
  }
}