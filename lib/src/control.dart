import 'dart:async';

import 'package:flutter/material.dart';
// import 'src/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'routes.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: const Controller(),
      routes: AppRoute.all,
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)),
    );
  }
}

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _Controllerstate();
}

class _Controllerstate extends State<Controller> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String realtimeValue = '0';
  String getonce = '0';
  bool _lightison = false;
  String ledstate = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("firebase example")),
      body: FutureBuilder(
        future: _fApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something wrong");
          } else if (snapshot.hasData) {
            return Controlwg();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget Controlwg() {
    final db = FirebaseDatabase.instance.ref();
    DatabaseReference testRef =
        FirebaseDatabase.instance.ref().child('ESP/Relay');
    testRef.onValue.listen((event) {
      setState(() {
        realtimeValue = event.snapshot.value.toString();
      });
    });
    if (realtimeValue == '0') {
      _lightison = false;
    } else if (realtimeValue == '1') {
      _lightison = true;
    }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.settings,
            size: 40,
            color: Colors.white,
          ),
          title: const Text(
            "Controller",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: FractionalOffset.center,
              height: height * .32,
              width: width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 3.0)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Icon(
                        Icons.lightbulb_outlined,
                        color:
                            _lightison ? Colors.yellow.shade600 : Colors.white,
                        size: height * .23,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // _lightison = !_lightison;
                        final led = db.child('ESP');
                        final snapshot = await testRef.get();
                        if (snapshot.exists) {
                          getonce = snapshot.value.toString();
                          if (getonce == "0") {
                            led.update({"Relay": "1"});
                            setState(() {
                              _lightison = true;
                            });
                          } else if (getonce == "1") {
                            led.update({"Relay": "0"});
                            setState(() {
                              _lightison = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow.shade600),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          _lightison ? 'Turn on' : 'Turn off',
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    )
                  ]),
            )),
        floatingActionButton: FloatingActionButton.large(
          hoverElevation: 50,
          tooltip: 'back',
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.home);
          },
          child: const Icon(Icons.arrow_back),
        ));
  }
}
