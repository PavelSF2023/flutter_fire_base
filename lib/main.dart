import 'package:flutter/material.dart';
import 'package:flutter_fire_base/widgets/app.dart';
import 'package:flutter_fire_base/widgets/main_screen.dart';



void main() =>  runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.red,
  ),
  initialRoute: '/',
  routes: {//роутер, организован как пара: ключ-значение, где ключ это url, а значение это функция, запускающая нужный виджет.
    '/': (conttext) => MainScreen(),
    '/todo': (context) => App(),
  },
));

