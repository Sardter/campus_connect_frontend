import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const width = 500;
    return AppPage(
        title: "Auth",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth > width ? (screenWidth - width) / 2 : 0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 50),
              const Text.rich(
                TextSpan(
                    style: TextStyle(
                        fontSize: 25, fontFamily: ThemeService.headlineFont),
                    children: [
                      TextSpan(
                          text: "Campus",
                          style: TextStyle(color: ThemeService.eventColor)),
                      TextSpan(
                        text: "Connect",
                      )
                    ]),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: widget.child,
              )
            ],
          ),
        ));
  }
}
