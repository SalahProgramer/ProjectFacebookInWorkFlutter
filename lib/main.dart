import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:projectflutterfacebook/providerFile.dart';
import 'package:provider/provider.dart';
import 'animation.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'home.dart';


void main() {
  runApp(
    
   ChangeNotifierProvider(
      create: (BuildContext context) {

        return fileImage();
      },
      child: GetMaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home:Screen(),
      ),
    ),
  );
}
class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/Curves.png"), fit: BoxFit.cover)),

         child: Center(
           child: AnimatedSplashScreen(
              splash: 'images/result.png',
              backgroundColor: Colors.transparent,
              nextScreen: home(),
              curve: Curves.bounceOut,
              animationDuration: Duration(seconds: 5),
              splashTransition: SplashTransition.scaleTransition,

            ),
         )




    );
  }
}




