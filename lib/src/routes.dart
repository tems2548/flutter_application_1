import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/buttomnavi.dart';
import 'package:flutter_application_1/src/register.dart';

import 'loginpage.dart';

class AppRoute {
  static const login = 'login';
  static const register = 'register';
  static const navdata = 'nav';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(),
        register: (context) => const Register(),
        navdata: (context) => const Navdata()
      };
}
