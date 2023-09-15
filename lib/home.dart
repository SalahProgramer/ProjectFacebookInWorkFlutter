import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:projectflutterfacebook/postAndComments/post.dart';
import 'package:projectflutterfacebook/providerFile.dart';
import 'package:projectflutterfacebook/register.dart';
import 'package:projectflutterfacebook/user.dart';
import 'package:provider/provider.dart';

import 'Controllers/getUsers.dart';
import 'Controllers/login_controller.dart';
import 'animation.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool passowrd = true;

  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool isloadingphone = false;
  bool visible = true;
  loginController login = Get.put(loginController());


  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlertSet=false;
  List<post> h = [];

  @override
  void initState() {
    getConnectivity();
checkActivity();
super.initState();
  }


  checkActivity()async{

   var result=await Connectivity().checkConnectivity();

if(result.name=='none'){

   isDeviceConnected=false;
   if(!isDeviceConnected && isAlertSet==false){
     showDialogBox();
     setState(() {
       isAlertSet=true;
     });

   }
}

}
  getConnectivity(){

  subscription=Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{

    isDeviceConnected= await InternetConnectionChecker().hasConnection;

     if(!isDeviceConnected && isAlertSet==false){
      showDialogBox();
      setState(() {
        isAlertSet=true;
      });

    }

  });



  }
@override
  void dispose() {

    subscription.cancel();

    super.dispose();
  }
  Future<void> fetchData() async {
    final response = await getUser().getUsers();

    setState(() {
      h = response;
      print(h.length.toString()+"             gggggggggggggggggggggggggggggggggggg");



    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/Curves.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Form(
            key: _formKey,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 55,
                                color: Colors.black,
                                fontFamily: "Pacifico"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.5
                                : MediaQuery.of(context).size.width * 0.8,
                            margin:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextFormField(

                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: login.email,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'fill the email';
                                } else if ((value.toString().trim().isEmail) ==
                                    false) {
                                  return ' The email is not correct';
                                }
                              },
                              cursorColor: Colors.black,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                  // filled: true,
                                  // fillColor: Colors.transparent,

                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.black))
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderRadius:
                                  //     BorderRadius.all(Radius.circular(20)))
                                  ),

                              keyboardType: TextInputType.emailAddress,
                              autofillHints: [AutofillHints.email],
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            width: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.5
                                : MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: login.password,
                              obscureText: passowrd,
                              cursorColor: Colors.black,

                              validator: (value) {
                                if (value.toString().isEmpty &&
                                    value.toString().length < 6) {
                                  return 'Fill the password and You should the password at least 6 characters';
                                } else if (value.toString().isEmpty) {
                                  return 'Fill the password';
                                } else if (value.toString().length < 6) {
                                  return 'You should the password at least 6 characters';
                                }
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        //
                                        passowrd = !passowrd;
                                        //
                                      });
                                    },
                                    icon: Icon(
                                      (passowrd == true
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      color: Colors.black,
                                    ),
                                  ),
                                  filled: true,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  hintText:
                                      "Enter the password should at least 6 character ",
                                  hintStyle: TextStyle(
                                      color: Colors.black45, fontSize: 15),
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.black))),

                              keyboardType: TextInputType.visiblePassword,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          width: MediaQuery.of(context).size.width >= 600
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.45
                                : MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 2,
                                      blurRadius: 30,
                                      blurStyle: BlurStyle.outer)
                                ],
                                // border: Border.all(color: Colors.black,width: 2),
                                gradient: LinearGradient(colors: [
                                  Colors.blueAccent,
                                  Colors.black,

                                  // Colors.white38,
                                ], transform: GradientRotation(90)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Consumer<fileImage>(
                              builder: (context, value, child) {
                                return   ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                    onPressed: () async {
                                      setState(() {
                                        isloading = true;
                                      });
                                      setState(() async {
                                        if (_formKey.currentState!.validate()) {

                                          await login.loginWithEmail();
                                          setState(() {
                                            isloading = false;

                                          });
                                          if (login.check == true) {
                                           await fetchData();
                                              value.changelist(h);
print(value.h);
                                            Navigator.of(context)
                                                .pushReplacement(animation(page: user()));




                                          }
                                          else{
                                            isloading = false;

                                          }

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) => profile(),
                                          //     ));
                                        }
                                        else{
                                          isloading = false;

                                        }
                                      });
                                    },
                                    child: isloading
                                        ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                              color: Colors.lightBlueAccent,
                                              strokeWidth: 1),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text("LOGIN".toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                  "fonts/TrajanPro.ttf"))
                                        ])
                                        : Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.login),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "LOGIN".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                              "fonts/TrajanPro.ttf"),
                                        ),
                                      ],
                                    ));

                              },

                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "fonts/TrajanPro.ttf")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(animation(page: register()));
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 15),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  showDialogBox()=> showCupertinoDialog<String>(context: context, builder: (context) {
    return CupertinoAlertDialog(

      actionScrollController: ScrollController(
        keepScrollOffset: true,
        initialScrollOffset: 10
      ),
      title: Text("No Connection",style: TextStyle(fontWeight: FontWeight.bold )),
      content: Text("Please Check your internet Connectivity",style: TextStyle(fontFamily:'CrimsonText',fontSize: 15,color: Colors.black87),),
      actions: [
TextButton(onPressed: ()async{
Navigator.pop(context,'Cancel');
setState(()  {
  isAlertSet=false;
});
isDeviceConnected= await InternetConnectionChecker().hasConnection;
if(!isDeviceConnected){

  showDialogBox();
  setState(() {
    isAlertSet=true;
  });
}
}, child: Text("OK"))

      ],


    );

  },);
}
