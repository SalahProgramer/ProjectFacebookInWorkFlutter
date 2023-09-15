import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:projectflutterfacebook/home.dart';
import 'package:projectflutterfacebook/providerFile.dart';
import 'package:provider/provider.dart';

import 'Controllers/registeration_controller.dart';
import 'animation.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  String? verify;

  bool passowrd = true;
  bool conpassowrd = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conpass = TextEditingController();
  TextEditingController name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isloading = false;
  bool isloadingphone = false;
  bool visible = true;
  String number = "";
  RegisteraionController  register=  Get.put(  RegisteraionController());
  @override
  void initState() {
    super.initState();
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
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Register",
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
                        Stack(
                          alignment: FractionalOffset(1.2, 1.2),
                          children: [
                            Consumer<fileImage>(
                              builder: (context, value, child) {
                                print(value.file!.path+" hhhhhhhhhhhhhhhhhhhhhhhh");

                                if(value.file.path!=""){

                                  return CircleAvatar(

                                    backgroundImage:

                                    FileImage(value.file2()),


                                    radius: 50,
                                  );


                                }
                                else{


                                  return

                                    Stack(
alignment: Alignment.center,
                                      children: [
                                        Container(

                                          child: CircleAvatar(

                                            backgroundImage:


                                            FileImage(value.file2()),



                                            radius: 50,
                                            backgroundColor: Colors.white,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(52),
                                            border: Border.all(color: Colors.black,width: 2)

                                          ),
                                        ),
                                CircularProgressIndicator(backgroundColor: Colors.black,strokeWidth: 3,color: Colors.white,)


                                ],
                                    );

                                }

                              },
                            ),
                            IconButton(
                              splashRadius: 100,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                          alignment: Alignment.center,
                                          child: AlertDialog(
                                            elevation: 19,
                                            alignment: Alignment.center,
                                            shadowColor: Colors.red,
                                            shape: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 5,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .shortestSide *
                                                  0.4,
                                              child: Column(
                                                children: [
                                                  Consumer<fileImage>(builder: (context, value, child) {

                                                    return  TextButton(
                                                        onPressed: () async{
                                                          await value
                                                              .changeFileCamera();
                                                          Navigator.pop(context);

                                                        },
                                                        child: Text(
                                                          "Take a Camera"
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.blue,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ));



                                                  },),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Consumer<fileImage>(
                                                    builder: (context, value,
                                                        child) {
                                                      return TextButton(
                                                          onPressed: () async{
                                                            await value
                                                                .changeFileGalary();
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                              "Select a Gallary"
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)));
                                                    },
                                                  )
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                            ),
                                            actions: [],
                                            title: Text(
                                              "Choose the Picture",
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.black,
                                                  fontFamily: "Pacifico",
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                    },
                                  );
                                },
                                icon: Icon(Icons.add_a_photo, size: 35),
                                color: Colors.black)
                          ],
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextFormField(
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: register.name,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'fill the name';
                                }
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                  // filled: true,
                                  // fillColor: Colors.transparent,

                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.person,
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

                              keyboardType: TextInputType.name,
                              autofillHints: [AutofillHints.name],
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextFormField(
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: register.email,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'fill the email';
                                } else if ((value
                                        .toString()
                                        .trim()
                                        .isEmail) ==
                                    false) {
                                  return ' The email is not correct';
                                }
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                  // filled: true,
                                  // fillColor: Colors.transparent,

                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
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
                            child: TextFormField(
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: register.password,
                              obscureText: passowrd,

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
                                  labelStyle: TextStyle(color: Colors.black),
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
                          height: 25,
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextFormField(
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: register.copassword,
                              obscureText: conpassowrd,

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
                                        conpassowrd = !conpassowrd;
                                        //
                                      });
                                    },
                                    icon: Icon(
                                      (conpassowrd == true
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      color: Colors.black,
                                    ),
                                  ),
                                  filled: true,
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(color: Colors.black),
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
                          height: 22,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 340,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                gradient: LinearGradient(colors: [
                                  Colors.blueAccent,
                                  Colors.black,
                                ], transform: GradientRotation(90)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ElevatedButton(
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

                                  if (_formKey.currentState!.validate())  {
                                    if (register.copassword.text.toString() ==
                                        (register.password.text.toString())) {


                                    await register.registerWithEmail();

                                       setState(() {
                                         isloading = false;
                                       });

                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Thr password not match",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blue,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                      setState(() {
                                        isloading = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
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
                                            Text("Sign up".toUpperCase(),
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
                                            "Sign up".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    "fonts/TrajanPro.ttf"),
                                          ),
                                        ],
                                      ))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Have an account?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontFamily: "fonts/TrajanPro.ttf")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(animation(page: home()));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 19),
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
}
