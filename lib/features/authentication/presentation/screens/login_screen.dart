import 'package:flutter/material.dart';
import 'package:loan_app/features/authentication/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(),
      ),
      extendBody: true,
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log in",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              sizedBoxFifteen,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthTextField(hintText: 'Username'),
                    sizedBoxFifteen,
                    AuthTextField(hintText: 'Password'),
                    sizedBoxFifteen,
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 0.9, 50),
                          primary: Colors.black,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: BorderSide(color: Colors.black, width: 0.9),
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 12),
                        ))
                  ],
                ),
              ),
              sizedBoxFifteen,
              Text(
                "Forgot password",
                style: TextStyle(color: Color(0xFFA4A4A4)),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Color(0xFFA4A4A4)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sign up on Leaf Wallet",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget get sizedBoxFifteen => SizedBox(
      height: 15,
    );
