import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qizo_test/screens/homepage.dart';
import 'package:qizo_test/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool passwordVisible=false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Validate email and password
    if (email.isNotEmpty && password.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedEmail = prefs.getString('email');
      final String? savedPassword = prefs.getString('password');

      if (email == savedEmail && password == savedPassword) {
        prefs.setBool('isLoggedIn', true);
        Navigator.push(context, PageTransition(
            type: PageTransitionType.fade, child: HomePage()));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter your email and password.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    passwordVisible=true;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(46)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(height: 20),
                        Text('Email',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (email){
                            if(email!.isEmpty ){
                              return "Email id is required";
                            }else
                              return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'Your email id'
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: passwordVisible,
                          validator: (pass) {
                            if (pass == null || pass.trim().isEmpty) {
                              return 'Password is required';
                            }
                            if (pass.trim().length < 8) {
                              return 'Password must be at least 8 characters in length';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                      () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextButton(
                                onPressed: (){
                                  _login(context);
                                }, child: Text('Login',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don’t have an account? ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, PageTransition(
                                    type: PageTransitionType.fade, child: SignUp()));
                              },
                              child: Text('Sign up',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}