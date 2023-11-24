import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/widget/pages/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Image.asset("assets/images/free-icon-user-5617164.png")
                ),
                SizedBox(
                  height: 300,
                  child: FutureBuilder(
                    future: DBProvider.db.getLoginUser(),
                     builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top:30),
                                child: Text("Имя: ${snapshot.data!.name}", style: TextStyle(fontSize: 20),)),
                               Padding(
                                padding: EdgeInsets.only(top:10),
                                child: Text("Фамилия: ${snapshot.data!.surname}", style: TextStyle(fontSize: 20))),
                              Padding(
                                padding: EdgeInsets.only(top:10),
                                child:Text("Email: ${snapshot.data!.email}", style: TextStyle(fontSize: 20))),
                              Padding(
                                padding: EdgeInsets.only(top:30),
                                child: TextButton(
                                  onPressed: () {
                                    DBProvider.db.logoutUser();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                                  },
                                  child: Text("Выйти из профиля")),
                              )
                            ]),
                        );
                      } else {
                        return Text("Загрузка");
                      }
                      
                
                     }),
                )

          ],
          ),
        ),
      )
    );
  }
}