import 'dart:math';

import 'package:flutter/material.dart';
// import 'src/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'box.dart';
import 'routes.dart';

class Naviga extends StatelessWidget {
  const Naviga({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: const Navdata(),
      routes: AppRoute.all,
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)),
    );
  }
}

class Navdata extends StatefulWidget {
  const Navdata({super.key});

  @override
  State<Navdata> createState() => _Navdatastate();
}

class _Navdatastate extends State<Navdata> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String realtimeValue = '0';
  String check = '0';
  String getonce = '0';
  String temperature = '0';
  String humidity = '0';
  String pressure = '0';
  int currentindex = 0;
  String pm10 = '0';
  String pm2_5 = '0';
  String pm1_0 = '0';
  bool _lightison = false;
  String ledstate = '0';
  String carbondi = '0';
  String carbonmono = '0';
  String tvocdata = '0';
  bool touch = false;
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
            return Scaffold(
              bottomNavigationBar: SizedBox(
                height: 90,
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.signpost,
                        size: 50,
                      ),
                      label: 'Main',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.cloud,
                          size: 40,
                        ),
                        label: 'Home',
                        activeIcon: Icon(
                          Icons.cloud_done_outlined,
                          size: 40,
                        )),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.thermostat,
                        size: 40,
                      ),
                      label: 'Enviroment',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings,
                        size: 40,
                      ),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.co2,
                        size: 40,
                      ),
                      label: 'gas',
                    ),
                  ],
                  currentIndex: currentindex,
                  selectedItemColor: Colors.amber[800],
                  onTap: _onItemTapped,
                ),
              ),
              body: [
                mainmenu(),
                aqi(),
                content(),
                controlwg(),
                gas()
              ][currentindex],
            );
          } else {
            return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  strokeWidth: 7.0,
                ));
          }
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentindex = index;
    });
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
          Icons.thermostat,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          "Enviroment",
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
              amoutsize: height * .3 / 4,
              textcolor: Colors.white,
              fontsized: height * .3 / 7,
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
              amoutsize: height * .3 / 4,
              textcolor: Colors.white,
              fontsized: height * .3 / 7,
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
              amoutsize: height * .3 / 4,
              textcolor: Colors.white,
              fontsized: height * .3 / 9,
              si: "hPa",
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget gas() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    DatabaseReference co2 = FirebaseDatabase.instance.ref().child('ESP/CO2');
    co2.onValue.listen((event) {
      setState(() {
        carbondi = event.snapshot.value.toString();
      });
    });
    DatabaseReference co = FirebaseDatabase.instance.ref().child('ESP/CO');
    co.onValue.listen((event) {
      setState(() {
        carbonmono = event.snapshot.value.toString();
      });
    });
    DatabaseReference tvoc = FirebaseDatabase.instance.ref().child('ESP/TVOC');
    tvoc.onValue.listen(
      (event) {
        setState(() {
          tvocdata = event.snapshot.value.toString();
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.co2_outlined,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          "GAS",
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
              title: "CO2",
              amount: carbondi,
              color: const Color.fromARGB(44, 255, 255, 255),
              size: height * .18,
              amoutsize: height * .14 / 2,
              textcolor: Colors.white,
              fontsized: height * .14 / 2,
              si: "ppm",
            ),
            SizedBox(
              height: height * .1 / 5,
            ),
            BoxWidget(
              title: "CO",
              amount: carbonmono,
              color: const Color.fromARGB(44, 255, 255, 255),
              size: height * .18,
              amoutsize: height * .14 / 2,
              textcolor: Colors.white,
              fontsized: height * .14 / 2,
              si: "ppm",
            ),
            SizedBox(
              height: height * .1 / 5,
            ),
            BoxWidget(
              title: "TVOC",
              amount: tvocdata,
              color: const Color.fromARGB(44, 255, 255, 255),
              size: height * .18,
              amoutsize: height * .2 / 3,
              textcolor: Colors.white,
              fontsized: height * .14 / 3,
              si: "PPB",
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget aqi() {
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
              fontsized: height * .1,
              amoutsize: height * .10,
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
              fontsized: height * .2 / 4,
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
                fontsized: height * .2 / 4,
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
                fontsized: height * .2 / 4,
                si: "µg/m³")
          ],
        ),
      ),
    );
    return scaffold;
  }

  Widget controlwg() {
    final db = FirebaseDatabase.instance.ref();
    DatabaseReference testRef =
        FirebaseDatabase.instance.ref().child('ESP/Relay');
    testRef.onValue.listen((event) {
      setState(() {
        check = event.snapshot.value.toString();
      });
    });
    if (check == '0') {
      _lightison = false;
    } else if (check == '1') {
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
                      color: _lightison ? Colors.yellow.shade600 : Colors.white,
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
                        style: TextStyle(
                            fontSize: 30,
                            color: _lightison ? Colors.white : Colors.black),
                      ),
                    ),
                  )
                ]),
          )),
    );
  }

  Widget mainmenu() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            top: true,
            bottom: true,
            child: Stack(children: [
              Positioned(
                  top: height / 40,
                  left: 20,
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            touch = !touch;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: width * .90,
                            height: touch ? height * .30 : height * .60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 145, 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: height * .20 / 3,
                                  fontWeight: FontWeight.bold),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: AnimatedTextKit(animatedTexts: [
                                        TypewriterAnimatedText(
                                            "Made by Debsirin team",
                                            textAlign: TextAlign.start),
                                        TypewriterAnimatedText(
                                            "Dust Tracker monitering system",
                                            textAlign: TextAlign.start),
                                        TypewriterAnimatedText(
                                            "install at Debsirin school",
                                            textAlign: TextAlign.start),
                                      ]),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: height * .10 / 5),
                              child: AnimatedContainer(
                                padding: const EdgeInsets.all(10),
                                width: touch ? width * .50 : width * .90,
                                height: height * .20,
                                decoration: BoxDecoration(
                                    color: Colors.amber[600],
                                    borderRadius: BorderRadius.circular(20)),
                                duration: const Duration(milliseconds: 600),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: height * .2 / 10),
                                  child: Text(
                                      touch ? "This project" : "Envirosence",
                                      style: touch
                                          ? TextStyle(
                                              fontSize: height * .2 / 4,
                                              fontWeight: FontWeight.bold)
                                          : TextStyle(
                                              fontSize: height * .2 / 2.6,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: touch ? 1 : 0,
                              duration: const Duration(milliseconds: 600),
                              child: Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * .10 / 5, left: 20),
                                  child: AnimatedContainer(
                                    padding: const EdgeInsets.all(10),
                                    width: width * .35,
                                    height: height * .20,
                                    decoration: BoxDecoration(
                                        color: Colors.amber[400],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    duration: const Duration(milliseconds: 600),
                                    child: const Text("data"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        AnimatedOpacity(
                          opacity: touch ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              width: width * .90,
                              height: height * .25,
                              decoration: BoxDecoration(
                                  color: Colors.amber[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FittedBox(
                                  alignment: Alignment.bottomLeft,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  fit: BoxFit.cover,
                                  child: Image.network(
                                    "https://cdn.discordapp.com/attachments/816657587986104331/1113266729758507019/IMG_2649.jpg",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ])));
  }
}
