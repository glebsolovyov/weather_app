
import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/widget/pages/registration_screen.dart';

import '../ components/bottom_navigation.dart';
import '../ components/text_form_decoration.dart';
import '../../data/auth_validators.dart';
import '../../data/get_themes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> with TickerProviderStateMixin {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final formKey = GlobalKey<FormState>();
  late int buttonIndex;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    buttonIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: textFormDecoration("email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                      controller: _passwordController,
                      decoration: textFormDecoration("пароль"),
                      keyboardType: TextInputType.emailAddress,
                      validator: passwordValidator),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: buttonIndex == 1
                      ? authButton()
                      : registerButton(),
                ),
              ]),
        ),
      ),
    );
  }

  Padding registerButton() {
    return Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: register,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    ),
                                child: Text(
                                  "Регистрация",
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () => setState(() {
                                      if (buttonIndex == 1) {
                                        buttonIndex++;
                                      } else {
                                        buttonIndex--;
                                      }
                                    }),
                                child: Text("Уже есть аккаунт? Войдите"))
                          ],
                        ),
                      );
  }

  Padding authButton() {
    return Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                ),
                child: Text(
                  "Войти",
                ),
              ),
            ),
            TextButton(
                onPressed: () => setState(() {
                      if (buttonIndex == 1) {
                        buttonIndex++;
                      } else {
                        buttonIndex--;
                      }
                    }),
                child: Text(
                    "Еще нет аккаунта? Зарегестрируйтесь"))
          ],
        ),
      );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      var user = await DBProvider.db.getUserByEmail(_emailController.text);
      await DBProvider.db.loginUser(user);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
  }

  register() async {
    if (formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegistrationScreen(email: _emailController.text, password: _passwordController.text)));
    }
  }
}
