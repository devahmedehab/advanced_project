import 'package:app1/app/app.dart';
import 'package:app1/app/d_i.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());

}


