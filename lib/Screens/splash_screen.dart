import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Constants/constants.dart';
import 'package:todo_app/Screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color1, color2],
            )
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('TO DO APP', style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'HennyPenny',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),),
              ),
        SizedBox(

          child: DefaultTextStyle(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'CrimsonText',
                fontWeight: FontWeight.bold,
                letterSpacing: 1
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText("List your to-do's with us!",
                  speed: const Duration(milliseconds: 200),
                )
              ],

                ),

          ),
        ),
              const SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                  },
                  child: const Text('Get Started', style: TextStyle(
                      color: color1,
                      fontSize: 22,
                      fontFamily: 'CrimsonText',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                  ),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: const Size(150, 50)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
