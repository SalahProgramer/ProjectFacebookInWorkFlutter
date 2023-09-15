import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:projectflutterfacebook/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectflutterfacebook/UrlsAPI/ApiEndPoint.dart';
import 'package:http/http.dart' as http;

class RegisteraionController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController copassword = TextEditingController();

  final _pref = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try{

      var url =
        Uri.parse(apiEndPoint.baseurl + apiEndPoint.AuthEndPoint.RegisterEmail);
      print(name.text.toString()+" llllllllllllllllllllllllll");
      print(password.text.toString()+" llllllllllllllllllllllllll");

      var header = {'Content-Type': 'application/json'};
    Map body = {
      'name': name.text.toString(),
      'email': email.text.trim(),
      'password': password.text.toString()
    };
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: header);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['code'] == 0) {
        var token = json['data']['Token'];
        var id=json['data']['Id'].toString();
        var nam=json['data']['Name'].toString();
        print(token+"            kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
        final SharedPreferences? pref = await _pref;
        await pref?.setString("token", token);
        await pref?.setString("id", id.toString());
        await pref?.setString("name", nam.toString());
        name.clear();
        email.clear();
        password.clear();
        copassword.clear();

        Fluttertoast.showToast(msg: "Add success",toastLength: Toast.LENGTH_LONG,fontSize: 25,gravity: ToastGravity.TOP);
Get.off(user());
      }
      else if (json['code'] == 1){
        Fluttertoast.showToast(msg: " error : The email address you have entered is already registered",toastLength: Toast.LENGTH_LONG,fontSize: 25,gravity: ToastGravity.TOP);




      }
    }
    else{
      Fluttertoast.showToast(msg: " error : Unknown Error Occured",toastLength: Toast.LENGTH_LONG,fontSize: 25,gravity: ToastGravity.TOP);



    }

    } catch (e){
      Get.back();
      Fluttertoast.showToast(msg: 'error : ' + e.toString(),toastLength: Toast.LENGTH_LONG,fontSize: 25,gravity: ToastGravity.TOP,);


    }
  }
}
