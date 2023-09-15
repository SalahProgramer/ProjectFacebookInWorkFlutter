import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectflutterfacebook/postAndComments/post.dart';

class fileImage extends ChangeNotifier {
  late File file=File("");
  List<post> h = [];

  var imagrpicker = ImagePicker();
  changeFileGalary() async {
    var imagepicked = await imagrpicker.pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      file = File(imagepicked.path);
      print(file!.path);
      print(
          "======================================================================\n  " +
              imagepicked.name);
//start upload
      var random = Random().nextInt(10000000);
      var rand = "$random${imagepicked.name}";
    } else {
      print("null");
    }
    notifyListeners();
  }
  changelist(List<post> list) {

    h=list;
    notifyListeners();
  }
  changeFileCamera() async {
    var imagepicked = await imagrpicker.pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      file = File(imagepicked.path);
      print(file!.path);
      print(
          "======================================================================\n  " +
              imagepicked.name);
//start upload
      var random = Random().nextInt(10000000);
      var rand = "$random${imagepicked.name}";
    } else {
      print("null");
    }
    notifyListeners();
  }
  File file2(){
    return file;


  }
  List<post> list(){
    return h;


  }
}
