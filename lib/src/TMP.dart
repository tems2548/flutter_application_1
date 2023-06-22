import 'package:flutter/material.dart';
// import 'src/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'box.dart';
import 'routes.dart';

class DIStmp extends StatelessWidget {
  const DIStmp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: const DataTMP(),
      routes: AppRoute.all,
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)),
    );
  }
}

class DataTMP extends StatefulWidget {
  const DataTMP({super.key});

  @override
  State<DataTMP> createState() => _DataTMPstate();
}

class _DataTMPstate extends State<DataTMP> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String realtimeValue = '0';
  String getonce = '0';
  String temperature = '0';
  String humidity = '0';
  String pressure = '0';
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
            return content();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget content() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    DatabaseReference temp = FirebaseDatabase.instance.ref().child('ESP/temp');
    temp.onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value.toString();
      });
    });
    DatabaseReference humid =
        FirebaseDatabase.instance.ref().child('ESP/humid');
    humid.onValue.listen((event) {
      setState(() {
        humidity = event.snapshot.value.toString();
      });
    });
    DatabaseReference press =
        FirebaseDatabase.instance.ref().child('ESP/pressure');
    press.onValue.listen(
      (event) {
        setState(() {
          pressure = event.snapshot.value.toString();
        });
      },
    );

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.cloud,
            size: 30,
            color: Colors.white,
          ),
          title: const Text(
            "TMP",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: height * .1 / 5,
              ),
              BoxWidget(
                title: "Temperture",
                amount: temperature,
                color: const Color.fromARGB(44, 255, 255, 255),
                size: height * .18,
                amoutsize: 60,
                textcolor: Colors.white,
                fontsized: 25,
                si: "°C",
              ),
              SizedBox(
                height: height * .1 / 5,
              ),
              BoxWidget(
                title: "Humidity ",
                amount: humidity,
                color: const Color.fromARGB(44, 255, 255, 255),
                size: height * .18,
                amoutsize: 60,
                textcolor: Colors.white,
                fontsized: 30,
                si: "% RH",
              ),
              SizedBox(
                height: height * .1 / 5,
              ),
              BoxWidget(
                title: "Preasure",
                amount: pressure,
                color: const Color.fromARGB(44, 255, 255, 255),
                size: height * .18,
                textcolor: Colors.white,
                fontsized: 30,
                si: "hPa",
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
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
