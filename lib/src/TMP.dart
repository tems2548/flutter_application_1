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
      theme: ThemeData(primarySwatch: Colors.grey),
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
  String pm10 = '0';
  String pm2_5 = '0';
  String pm1_0 = '0';
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
    DatabaseReference testRef =
        FirebaseDatabase.instance.ref().child('ESP/AQI');
    testRef.onValue.listen((event) {
      setState(() {
        realtimeValue = event.snapshot.value.toString();
      });
    });
    DatabaseReference particle =
        FirebaseDatabase.instance.ref().child('ESP/PM 10');
    particle.onValue.listen((event) {
      setState(() {
        pm10 = event.snapshot.value.toString();
      });
    });
    DatabaseReference particle2_5 =
        FirebaseDatabase.instance.ref().child('ESP/PM 2_5');
    particle2_5.onValue.listen(
      (event) {
        setState(() {
          pm2_5 = event.snapshot.value.toString();
        });
      },
    );
    DatabaseReference particle1_0 =
        FirebaseDatabase.instance.ref().child('ESP/PM 1_0');
    particle1_0.onValue.listen((event) {
      setState(() {
        pm1_0 = event.snapshot.value.toString();
      });
    });

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
              const SizedBox(
                height: 20,
              ),
              BoxWidget(
                  title: "Temperture",
                  amount: realtimeValue,
                  color: Colors.blueGrey,
                  size: 170),
              const SizedBox(
                height: 20,
              ),
              BoxWidget(
                  title: "Humidity",
                  amount: pm10,
                  color: Colors.blueGrey,
                  size: 170),
              const SizedBox(
                height: 20,
              ),
              BoxWidget(
                  title: "Preasure",
                  amount: pm2_5,
                  color: Colors.blueGrey,
                  size: 170),
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
