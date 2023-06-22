import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/TMP.dart';
import 'package:flutter_application_1/src/register.dart';

import 'loginpage.dart';
import 'menu.dart';
import 'Data.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const register = 'register';
  static const data = 'data';
  static const tmpdata = 'tmp';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(),
        home: (context) => const MyApp(),
        register: (context) => const Register(),
        data: (context) => const Dis(),
        tmpdata: (context) => const DIStmp()
      };
}