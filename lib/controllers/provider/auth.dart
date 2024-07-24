import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier
{

  static String user = "";

  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth{
    return token != null;
  }

  String? get token{
    if(_expiryDate != null && _expiryDate!.isAfter(DateTime.now())&&_token != null){
      return _token;
    }else{
      return null;
    }
}


  Future<void> _authenticate(String email,String password,String urlSegment) async{

    final url="https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAMRuuExrBRVPS8FE1JZvySsAPK36uAmlQ";
    try
        {
          final res= await http.post(Uri.parse(url), body: json.encode({
            'email':email,
            'password':password,
            'returnSecureToken': true
          }));
          final resData = json.decode(res.body);
          if(resData['error'] != null)
            {
              throw '${resData['error']['message']}';
            }


          _token =resData['idToken'];
          _userId =resData['localId'];
          _expiryDate= DateTime.now().add(Duration(seconds: int.parse(resData['expiresIn'])));

          notifyListeners();

          final prefs=await SharedPreferences.getInstance();
          final userData = json.encode({
            'token': _token,
            'userId':_userId,
            'expiryDate':_expiryDate?.toIso8601String()
          });
          prefs.setString("userData", userData);
        }
        catch(error){
      rethrow;
        }

  }



  Future<void> signUp(String email,String password) async
  {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email,String password) async
  {
    return _authenticate(email, password, "signInWithPassword");
  }

  void logOut(){
  _token =null;
  _userId =null;
  _expiryDate= null;
  notifyListeners();
}

static bool loading = false;

  // Chat auth
  static String userToken = "";
  static String name = "";
  static String image = "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg";
  static String phone = "";
  static String email = "";
  static String stateLog = "";
}