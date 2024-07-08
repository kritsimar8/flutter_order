import 'package:burger_delivery/auth/login_register.dart';
import 'package:burger_delivery/models/restaurant.dart';
import 'package:burger_delivery/pages/login_page.dart';
import 'package:burger_delivery/pages/register_page.dart';
import 'package:burger_delivery/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
   MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),

      ChangeNotifierProvider(create: (context)=>Restaurant()),
    ],
    child:const MyApp(),
   )
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner:false,
      home: const LoginOrRegister(),
      theme:Provider.of<ThemeProvider>(context).themeData,
    );
  }
}