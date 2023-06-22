import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/routes.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LOGIN",
      home: const LoginPage(),
      routes: AppRoute.all,
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  int _debug = 0;
  @override
  void initState() {
    super.initState();
    _username.text = "";
    _password.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 400,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._buildTextinput(),
                      const SizedBox(
                        height: 10,
                      ),
                      ..._buildbutton(),
                    ]),
              ),
            ),
          ),
        ));
  }

  void _handleClick() {
    // print("login : (${_username.text},${_password.text})");
    if (_username.text == 'admin' && _password.text == '12345') {
      Navigator.pushNamed(context, AppRoute.navdata);
    } else {
      _username.text = "unknow User";
    }
  }

  void _handleReset() {
    _username.text = "";
    _password.text = "";
  }

  _buildbutton() {
    return [
      ElevatedButton(
        onPressed: _handleClick,
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 55, 0, 179))),
        child: const Text("Login"),
      ),
      OutlinedButton(
          onPressed: _handleReset,
          child: const Text(
            "reset",
            style: TextStyle(color: Colors.white),
          )),
      OutlinedButton(
          onPressed: _handleRegister,
          child: const Text(
            "register",
            style: TextStyle(color: Colors.white),
          ))
    ];
  }

  _buildTextinput() {
    return [
      TextField(
        controller: _username,
        decoration: const InputDecoration(labelText: "USERNAME"),
      ),
      TextField(
        controller: _password,
        decoration: const InputDecoration(labelText: "PASSWORD"),
      ),
    ];
  }

  void _handleRegister() {
    Navigator.pushNamed(context, AppRoute.register);
  }

  void _add() {
    _debug++;
    setState(() {});
  }

  void _remove() {
    _debug--;
    setState(() {});
  }
}
