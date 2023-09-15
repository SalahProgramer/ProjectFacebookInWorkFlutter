import 'package:flutter/cupertino.dart';

class animation extends PageRouteBuilder {
  final page;

  animation({this.page})
      : super(
      pageBuilder: (context, animation, animationTwo) => page,
      transitionsBuilder: (context, animation, animationTwo, child) {
        // var begin= Offset(0, 1);
        // var end =Offset(0, 0);
        // var tween= Tween(begin:  begin,end:  end);
        // var offsetanimation= animation.drive(tween);
        // var curvanimation= CurvedAnimation(parent: animation, curve: Curves.easeInCirc);
        // return SlideTransition(position: tween.animate(curvanimation),child: child,);
        // var begin= 0.0;
        // var end =1.0;
        // var tween= Tween(begin:  begin,end:  end);
        // var offsetanimation= animation.drive(tween);
        // var curvanimation= CurvedAnimation(parent: animation, curve: Curves.easeInCirc);
        // return ScaleTransition(scale: tween.animate(curvanimation),child: child,);
        var begin= 0.0;
        var end =1.0;




        var tween= Tween(begin:  begin,end:  end);
        // var offsetanimation= animation.drive(tween);
        var curvanimation= CurvedAnimation(parent: animation, curve: Curves.easeInOutCubicEmphasized);
        return RotationTransition(turns: tween.animate(curvanimation),child: child,);
        // return Align(
        //     alignment: Alignment.center,
        //     child: SizeTransition(
        //       sizeFactor: animation,
        //       child: child,
        //     ));
        // var begin= 0.0;
        // var end =1.0;
        // var tween= Tween(begin:  begin,end:  end);
        // var offsetanimation= animation.drive(tween);
        // var curvanimation= CurvedAnimation(parent: animation, curve: Curves.easeInOutCubicEmphasized);
        // return FadeTransition(opacity: animation,child: RotationTransition(turns: tween.animate(curvanimation),child: child,),);
      });
}