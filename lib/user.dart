import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:projectflutterfacebook/Controllers/getUsers.dart';
import 'package:projectflutterfacebook/animation.dart';
import 'package:projectflutterfacebook/home.dart';
import 'package:projectflutterfacebook/providerFile.dart';
import 'package:projectflutterfacebook/register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectflutterfacebook/postAndComments/post.dart';

class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  String? note;
  String? id;
  String? name;
  List<post> h = [];


  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

int index1=1;
int counter=0;
  @override
  void initState() {
    getNode();
   fetchData();
    super.initState();
  }
  Future<void> fetchData() async {
    final response = await getUser().getUsers();

    setState(() {
      h = response;



    });
  }
  @override
  Widget build(BuildContext context) {
    return



        WillPopScope(
          onWillPop: ()async{
           return await showDialog(
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
                            width: 5, color: Colors.black),
                        borderRadius:
                        BorderRadius.circular(25),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushAndRemoveUntil(context, animation(page: home()), (route) => false);
                                Get.off(register());

                                Get.off(home());
                                clear();
                              });
                            },
                            child: Text("Yes".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blue,
                                    letterSpacing: 1,
                                    fontFamily: 'CrimsonText',
                                    fontWeight:
                                    FontWeight.bold))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Text("No".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blue,
                                    letterSpacing: 1,
                                    fontWeight:
                                    FontWeight.bold,fontFamily: 'CrimsonText')))
                      ],
                      title: Text(
                        "Are you sure to exit?",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ));
              },
            );

          },

            child: Scaffold(

              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              bottomNavigationBar: ConvexAppBar(
                style: TabStyle.reactCircle,
                backgroundColor: Colors.blue,
                curve: Curves.easeInOutCirc,
                activeColor: Colors.blue,
                gradient: LinearGradient(colors: [
                  Colors.blue,
                  Colors.white,
                  Colors.red,
                ], transform: GradientRotation(20)),
                shadowColor: Colors.black,
                onTap: (index) {
                  setState(() {
                    index1 = index;
                    print(index1);
                    // if (index1 == 1) {
                    //   // Navigator.of(context).push(animation(page: person()));
                    // } else if (index1 == 3) {
                    //   // Navigator.of(context).push(animation(page: order()));
                    // } else if (index1 == 0) {
                    //   // Navigator.of(context).push(animation(page: nofication()));
                    // }
                  });
                },
                initialActiveIndex: index1,
                elevation: 20,
                items: [

                  TabItem(
                      icon: Icon(
                        Icons.person,
                      )),
                  TabItem(
                      icon: Icon(
                        Icons.home_sharp,
                      )),

                  TabItem(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      )),
                ],
              ),

              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,

                centerTitle: true,
                title: Text(name.toString(),style: TextStyle(fontWeight: FontWeight.w500,height: 1,
                    fontSize: 35,
                    color: Colors.black,
                    fontFamily: "Pacifico"),),
                leading:  Badge(
                    backgroundColor: Colors.green,
                    isLabelVisible: true,
                    alignment: Alignment.center,
                    offset: Offset(4, 3),
                    label: Text("0"),
                    largeSize: 10,
                    child: IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.add_alert_rounded,color: Colors.black,
                        ))),
                actions: [
                  IconButton(
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
                                        width: 5, color: Colors.black),
                                    borderRadius:
                                    BorderRadius.circular(25),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pushAndRemoveUntil(context, animation(page: home()), (route) => false);
                                            Get.off(register());

                                            Get.off(home());
                                            clear();
                                          });
                                        },
                                        child: Text("Yes".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.blue,
                                                letterSpacing: 1,
                                                fontFamily: 'CrimsonText',
                                                fontWeight:
                                                FontWeight.bold))),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("No".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.blue,
                                                letterSpacing: 1,
                                                fontWeight:
                                                FontWeight.bold,fontFamily: 'CrimsonText')))
                                  ],
                                  title: Text(
                                    "Are you sure to exit?",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));
                          },
                        );


                      },
                      icon: Icon(Icons.logout,color: Colors.black,),)
                ],
              ),
              body:
             Container(
                height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/Curves.png"), fit: BoxFit.fill)),
                      child: SafeArea(
                        child: Column(

                          children: [
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(top: 10),

                              child: Row(

                                children: [
                                  // SizedBox(width: 20,),

                                  CircleAvatar(

                                    backgroundImage:

                                    NetworkImage("http://restapi.adequateshop.com/Media//Images/userimageicon.png"),



                                    radius: 20
                                    ,
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
width: MediaQuery.of(context).size.width<600? MediaQuery.of(context).size.width*0.7: MediaQuery.of(context).size.width*0.85,                            height: 50,
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          floatingLabelAlignment: FloatingLabelAlignment.center,
                                          hintText: "Whats's on your mind?",
                                          contentPadding: EdgeInsets.all(10),
                                          alignLabelWithHint: true,

                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(color: Colors.black,width: 2)
                                          )
                                          ,
                                          enabledBorder:  OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(color: Colors.black,width: 2)
                                          )
                                      ),



                                    ),
                                  ),
                                  IconButton(onPressed: (){



                                  }, icon: Icon(Icons.image,color: Colors.black,))

                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                              ),

                            ),
                            SizedBox(height: 10,),
                            Consumer<fileImage>(
                              builder: (context, value, child) {

                                return Expanded(
                                    child: Container(
                                      height: 300,
                                      // padding: EdgeInsets.only(bottom: 100),
                                      child: value.h.length != 0
                                          ? RefreshIndicator(
                                        onRefresh: () async {
                                          await fetchData();
                                        },
                                        child:
                                        ListView.builder(itemCount: value.h.length,itemBuilder: (context, index) {
                                          return card(name: value.h[index].name.toString(),image: value.h[index].image.toString(),email: value.h[index].email.toString(),);

                                        }),
                                      ): Text("Not show Data"),
                                    )
                                );
                              },

                            )


                          ],
                        ),
                      ),

                ),



    ),

        );
  }

  void getNode() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      note = pref.get("token") as String?;
      id = pref.get("id") as String?;
      name = pref.get("name") as String?;

    });
    print(note.toString() +
        "                                   nooooooooooooooooooooooooooooooooooooooooooooooooooooooot");
  }

  void clear() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      note = null;
      pref.clear();
    });
    print(note.toString() +
        "                                   nooooooooooooooooooooooooooooooooooooooooooooooooooooooot");
  }
}
class card extends StatefulWidget {
final String name;
final String image;
final String email;

  const card({super.key,required this.name,required this.image,required this.email});

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
     
      child:   Card(

        shape: OutlineInputBorder(

          borderSide: BorderSide(color: Colors.black,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

Row(
  children: [
    CircleAvatar(

      backgroundImage:

      NetworkImage(""+this.widget.image),



      radius: 20
      ,
    ),
    SizedBox(width: 5,),


    Column(
      mainAxisAlignment: MainAxisAlignment.start,

      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text(this.widget.name.toString(),style: TextStyle(fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
            fontFamily: "Pacifico")),
        SizedBox(height: 5,)
        ,
        Text(this.widget.email.toString(),style: TextStyle(fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
            fontFamily: "CrimsonText")),


      ],

    )

  ],

),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.cancel)),

                    ],
                  )


                ],
              )

            ],


          ),
        ),

      ),
    );
  }
}
