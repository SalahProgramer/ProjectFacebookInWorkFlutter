import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:projectflutterfacebook/postAndComments/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:projectflutterfacebook/UrlsAPI/ApiEndPoint.dart';
import 'package:http/http.dart' as http;

class getUser{

  final _pref = SharedPreferences.getInstance();
  String? tok;
  int? count;



  late List<post> users;

  bool check=false;

  Future<List<post>> getUsers() async {

    try {
      await getToken();
      print("token after 2 : ${tok}");

      var url =
      Uri.parse(apiEndPoint.baseurl + apiEndPoint.AuthEndPoint.getUser);
      var header = {'Content-type': 'application/json',
                    'Authorization': 'Bearer ${tok}'};
      http.Response response =
      await http.get(url, headers: header,);
    
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final result = json['data'] as List<dynamic>;
        count=json['per_page'];

        print(response.statusCode.toString()+"                     fffffffffffffffffffffffffffffffffff");
        print(count.toString()+"                     fffffffffffffffffffffffffffffffffff");
        print(json['data'][0]['name'].toString()+"                     fffffffffffffffffffffffffffffffffff");

        users = result.map((e) {
          return post(name: e['name'], image: e['profilepicture'], email: e['email']);
        }).toList();

        Fluttertoast.showToast(
            msg: 'was show data',
            fontSize: 20,
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT);
        check=true;
        return users;





      } else {

        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occured";

      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'error : ' + e.toString());
      return users;

    }


  }
  getToken() async{
    final SharedPreferences pref = await _pref;

    tok=pref.getString("token");
    print("token after : ${tok}");


  }
}

