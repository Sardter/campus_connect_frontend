import 'package:campus_connect_frontend/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passVisible = false;

  Future<bool> _onSubmit(context) async {
    final result = await APIAuthServiceFactory.SERVICE.login(
            fields: AuthFields(
                username: _emailController.text,
                email: null,
                password: _passwordController.text)) ??
        false;
    
    if ((result == null || result['access_token'] == null) && (result['detail']=="Incorrect credentials")) {

      await showSocialUtilSnackbar(
          context: context,
          message: "Wrong credentials",
          type: DisplayMessageType.danger);
    }

    else if ((result == null || result['access_token'] == null) && (result['detail']=="Object does not exist")) {

      await showSocialUtilSnackbar(
          context: context,
          message: "User does not exist",
          type: DisplayMessageType.danger);
    }
    else {closePage(context);}
    return !(result == null || result['access_token'] == null);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        child: Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            RoundedTextField(
                prefix: const [
                  Icon(Icons.email, color: ThemeService.secondaryText),
                  SizedBox(width: 10)
                ],
                type: TextInputType.text,
                controller: _emailController,
                hint: "Email"),
            const SizedBox(height: 10),
            RoundedTextField(
                prefix: const [
                  Icon(Icons.vpn_key, color: ThemeService.secondaryText),
                  SizedBox(width: 10)
                ],
                suffix: [
                  GestureDetector(
                    onTap: () => setState(() => _passVisible = !_passVisible),
                    child: Icon(
                        _passVisible ? Icons.visibility : Icons.visibility_off),
                  )
                ],
                obscureText: !_passVisible,
                type: TextInputType.visiblePassword,
                controller: _passwordController,
                hint: "Şifre")
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          //margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          height: 40,
          child: SocialUtilButton(
            maximizeLength: true,
            children: const [
              Text(
                "Sign in",
                style: TextStyle(color: ThemeService.clubColor),
              )
            ],
            onTap: () => _onSubmit(context),
          ),
        ),
        const SizedBox(height: 20),
        Align(
            alignment: Alignment.center,
            child: GestureDetector(
              //onTap: () => launchPage(context, ForgotPasswordPage()),
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: const Text(
                    "     Forgot Password?",
                    style:
                       TextStyle(color: ThemeService.eventColor, fontSize: 11),
                  )),
            )),
        //SocialAuthWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Don't have account",
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            TextButton(
                onPressed: () {
                  closePage(context);
                  launchPage(context, const RegisterPage());
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 11,
                      color: ThemeService.eventColor,
                      fontWeight: FontWeight.w700),
                ))
          ],
        )
      ],
    ));
  }
}