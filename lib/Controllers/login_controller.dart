import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectflutterfacebook/UrlsAPI/ApiEndPoint.dart';
import 'package:http/http.dart' as http;

class loginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _pref = SharedPreferences.getInstance();
  bool check=false;

  Future<void> loginWithEmail() async {
    try {
      var url =
          Uri.parse(apiEndPoint.baseurl + apiEndPoint.AuthEndPoint.LoginEmail);
      var header = {'Content-type': 'application/json'};
      Map body = {'email': email.text.trim(), 'password': password.text.toString()};
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: header);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          var id=json['data']['Id'].toString();
          var nam=json['data']['Name'].toString();

          print(token+" token before");
          final SharedPreferences? pref = await _pref;
          await pref?.setString("token", token.toString());
          await pref?.setString("id", id.toString());
          await pref?.setString("name", nam.toString());

          email.clear();
          password.clear();
          Fluttertoast.showToast(msg: "Login successfully",toastLength: Toast.LENGTH_LONG,fontSize: 25,gravity: ToastGravity.TOP);
          check=true;
        } else  if (json['code'] == 1){
          Fluttertoast.showToast(msg: "Invalid password or email",toastLength: Toast.LENGTH_LONG,fontSize: 25,gravity: ToastGravity.TOP);
          check=false;

        }
      } else {
        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'error : ' + e.toString());
    }
  }
}
