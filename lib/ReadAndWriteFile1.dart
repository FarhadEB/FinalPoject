import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
void main(List<String> args) {
  File myfile=File("C:\\Users\\7th Generation\\Desktop\\TheFile.txt");
  // myfile.writeAsStringSync('Nothing to do \n',mode: FileMode.append);
  var read = myfile.readAsStringSync();
  print('$read ');

}