import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Constants/constants.dart';
import 'package:todo_app/Screens/home_screen.dart';
import 'package:todo_app/Screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final auth = FirebaseAuth.instance;
  bool hidePassword = true;
  late User loggedInUser;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  void getCurrentUser()async {
    final user = auth.currentUser;
    if(user != null){
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }


  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: globalFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                  color: color1,
                  fontSize: 40,
                  fontFamily: 'HennyPenny',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 20, top: 30),
              child: TextFormField(
                validator: (val){
                  if (val!.isEmpty) {
                    return 'Please enter email address';
                  } else if (!val.contains('@')) {
                    return 'Email Address should be valid';
                  } else {
                    return null;
                  }
                },
                controller: _emailController,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: color1,),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: color1,
                        fontSize: 20,
                      ),
                      hintText: 'Enter email address',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: color2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: color2)))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 50),
              child: TextFormField(
                validator: (val){
                  if (val!.isEmpty) {
                    return 'Please enter password';
                  } else if (val.length < 6) {
                    return 'Password should be more than 6 characters';
                  } else {
                    return null;
                  }
                },
                controller: _passwordController,
                  obscureText: hidePassword,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration:  InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color:  color1,),
                      suffixIcon: IconButton(
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: color1,
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: color1,
                        fontSize: 20,
                      ),
                      hintText: 'Enter password',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: color2)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: color2)))),
            ),
            ElevatedButton(
              onPressed: () async {
                if (globalFormKey.currentState!.validate()) {
                  globalFormKey.currentState!.save();
                  print('validated');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Blank field not allowed')));
                }
                try {
                  final user = await auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }
                } on SocketException {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No Internet, Please connect to the internet')));
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('$e')));
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'CrimsonText',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              style: ElevatedButton.styleFrom(
                  primary: color1, fixedSize: const Size(150, 50)),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
              child: RichText(
                text: const TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' SignUp',
                        style: TextStyle(
                            color: color1,
                            fontSize: 18,
                            fontFamily: 'CrimsonText',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
