import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/routes.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'box.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "my app",
        home: const Myhomepage(),
        routes: AppRoute.all,
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)));
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 255, 255, 255), size: 40),
          title: const Text(
            'MENU',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 30,
                wordSpacing: 10),
          ),
        ),
        body: SafeArea(
          top: true,
          bottom: true,
          child: Stack(children: [
            Positioned(
              left: width * .1 / 4,
              top: height * .25,
              child: InkWell(
                child: box(const Color.fromARGB(255, 55, 0, 179), "AQI"),
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.data);
                },
              ),
            ),
            Positioned(
              left: width * .50,
              top: height * .25,
              child: InkWell(
                  child: box(const Color.fromARGB(255, 55, 0, 179), "THP"),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.tmpdata);
                  }),
            ),
            Positioned(
                left: width * .1 / 4,
                top: height * .51,
                child: InkWell(
                  child: box(const Color.fromARGB(255, 55, 0, 179), "GAS"),
                  onTap: () {},
                )),
            Positioned(
                left: width * .50,
                top: height * .51,
                child: InkWell(
                  child: box(const Color.fromARGB(255, 55, 0, 179), "CMS"),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.command);
                  },
                )),
            Positioned(
                top: height * .76,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: width * .1 / 2,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(48, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          height: height * .12,
                          width: width * .95,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: AnimatedTextKit(animatedTexts: [
                              TypewriterAnimatedText("Made by Debsirin team",
                                  textAlign: TextAlign.center),
                              TypewriterAnimatedText(
                                  "Dust Tracker monitering system",
                                  textAlign: TextAlign.center),
                              TypewriterAnimatedText(
                                  "install at Debsirin school",
                                  textAlign: TextAlign.center),
                            ]),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                  height: height * .23,
                  width: width,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(0, 15))
                      ],
                      color: Color.fromARGB(255, 55, 0, 179),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255)
                    ]).createShader(bounds),
                    child: const DefaultTextStyle(
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 56,
                          fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                            "Enviroment "
                            "Tracker",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ))
          ]),
        ));
  }

  Padding box(Color color, String tx) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Ink(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(144, 203, 194, 210),
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(15, 15))
            ]),
        height: height * .22,
        width: width * .40,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                tx,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: width * 1 / 7,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
