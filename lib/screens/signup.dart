import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qizo_test/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool passwordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _signUp(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    // Validate input fields
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('password', password);
        prefs.setBool('isLoggedIn', true);
        Navigator.push(context, PageTransition(
            type: PageTransitionType.fade, child: LoginScreen()));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Error'),
            content: Text('Passwords do not match.'),
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
          content: Text('Please fill in all the fields.'),
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
                Text('Sign up',
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
                        horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.email,),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: emailController,
                                    validator: (email){
                                      if(email!.isEmpty ){
                                        return "Email id is required";
                                      }else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Email Address',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide( width: 2.0),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide( width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.lock_outline_rounded,),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  validator: (pass) {
                                    if (pass == null || pass.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    if (pass.trim().length < 8) {
                                      return 'Password must be at least 8 characters in length';
                                    }
                                    return null;
                                  },
                                  obscureText: passwordVisible,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide( width: 2.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1.0),
                                    ),
                                    hintText: 'Enter your password',
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
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.lock_outline_rounded,),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  obscureText: passwordVisible,
                                  controller: confirmPasswordController,
                                  validator: (pass) {
                                    if (pass == null || pass.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    if (pass.trim().length < 8) {
                                      return 'Password must be at least 8 characters in length';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide( width: 2.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide( width: 1.0),
                                    ),
                                    hintText: 'Confirm your password',
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
                              ),
                            ),
                          ],
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
                                  _signUp(context);
                                }, child: Text('Sign up',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a member?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, PageTransition(
                                    type: PageTransitionType.fade, child: LoginScreen()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
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
