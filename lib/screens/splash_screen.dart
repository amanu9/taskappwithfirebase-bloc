import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskappwithblocandfirebase/screens/login_screen.dart';
import 'package:taskappwithblocandfirebase/screens/tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   GetStorage _getStorage=GetStorage();// crating object of getstorange local data saving on machine
  @override
  void initState() {
    super.initState();
    nextPage(context);
  }

  void nextPage(BuildContext context) {
    // Set a delay of 3 seconds (3000 milliseconds)
    Timer(Duration(seconds: 3), () {
      // this check if the user token is null or not 
      if(_getStorage.read('token')==null || _getStorage.read('token')==''){
      Navigator.pushReplacementNamed(context, LoginScreen.id);
      }else{
         Navigator.pushReplacementNamed(context, TabsScreen.id);
      }
      //end of token check
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 16.0), 
            Text(
              'Loading',
              style: TextStyle(fontSize: 16.0, color: Colors.orangeAccent),
            ),
          ],
        ),
      ),
    );
  }
}
