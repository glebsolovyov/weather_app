import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';

import '../ components/bottom_navigation.dart';
import '../ components/text_form_decoration.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
    required this.email, 
    required this.password,
    });
  final String email;
  final String password;

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
    late TextEditingController _nameController;
    late TextEditingController _surnameController;

  int selectedIndex = 0;
 @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _nameController,
                  decoration: textFormDecoration("имя"),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
                  controller: _surnameController,
                  decoration: textFormDecoration("фамилию"),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: secondRegister,
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.3)),
                              child: Text(
                                "Регистрация",
                              ),
                            ),
                          )
        )
        ]
        )
      )
    );
  }
  secondRegister(){
    DBProvider.db.newUser(
      widget.email, 
      widget.password, 
      _nameController.text, _surnameController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavigation()));
  }
}

