import 'package:flutter/material.dart';
// import 'src/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'box.dart';
import 'routes.dart';

class Dis extends StatelessWidget {
  const Dis({super.key});

  @override
  Widget build(BuildContext context) {
    var appaqi = MaterialApp(
      title: "test",
      home: const Data(),
      routes: AppRoute.all,
      theme: ThemeData(
          brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black),
    );
    return appaqi;
  }
}

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _Datastate();
}

class _Datastate extends State<Data> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String realtimeValue = '0';
  String getonce = '0';
  String pm10 = '0';
  String pm2_5 = '0';
  String pm1_0 = '0';
  @override
  Widget build(BuildContext context) {
    var aqidata = FutureBuilder(
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
    );
    return Scaffold(
      // appBar: AppBar(title: const Text("firebase example")),
      body: aqidata,
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color aqicolor = Colors.yellow;
    int aqi = int.parse(realtimeValue);
    if (aqi < 25) {
      aqicolor = const Color.fromARGB(255, 152, 223, 255);
    } else if (aqi >= 25 && aqi <= 50) {
      aqicolor = const Color.fromARGB(255, 187, 255, 127);
    } else if (aqi > 50 && aqi <= 100) {
      aqicolor = const Color.fromARGB(255, 246, 255, 144);
    } else if (aqi > 100 && aqi <= 200) {
      aqicolor = const Color.fromARGB(255, 254, 175, 71);
    } else if (aqi > 200) {
      aqicolor = Colors.redAccent;
    }

    var scaffold = Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(56, 255, 255, 255),
          leading: const Icon(
            Icons.cloud,
            size: 40,
            color: Colors.white,
          ),
          title: const Text(
            "Air quality",
            style: TextStyle(
              fontSize: 25,
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
                height: height * .1 / 8,
              ),
              BoxWidget(
                title: "AQI",
                amount: realtimeValue,
                color: const Color.fromARGB(44, 255, 255, 255),
                size: height * .17,
                textcolor: aqicolor,
                fontsized: 70,
                amoutsize: 100,
              ),
              SizedBox(
                height: height * .1 / 6,
              ),
              BoxWidget(
                title: "PM 10 ",
                amount: pm10,
                color: const Color.fromARGB(44, 255, 255, 255),
                size: height * .17,
                textcolor: Colors.white,
                fontsized: 40,
                si: "µg/m³",
              ),
              SizedBox(
                height: height * .1 / 6,
              ),
              BoxWidget(
                  title: "PM 2.5",
                  amount: pm2_5,
                  color: const Color.fromARGB(44, 255, 255, 255),
                  size: height * .17,
                  textcolor: Colors.white,
                  fontsized: 40,
                  si: "µg/m³"),
              SizedBox(
                height: height * .1 / 6,
              ),
              BoxWidget(
                  title: "PM 1.0",
                  amount: pm1_0,
                  color: const Color.fromARGB(44, 255, 255, 255),
                  size: height * .17,
                  textcolor: Colors.white,
                  fontsized: 40,
                  si: "µg/m³")
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
    return scaffold;
  }
}
