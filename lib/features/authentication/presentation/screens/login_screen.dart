import 'package:flutter/material.dart';

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
          color: Colors.white,
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
                    TextField(hintText: 'Email'),
                    sizedBoxFifteen,
                    TextField(hintText: 'Password'),
                    sizedBoxFifteen,
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign In',
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
                height: MediaQuery.of(context).size.height / 8,
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

class TextField extends StatelessWidget {
  final String hintText;
  final int? maxlines;
  final validator, onsaved;

  const TextField(
      {required this.hintText, this.validator, this.onsaved, this.maxlines});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onsaved,
      keyboardType:
          hintText == 'Email' ? TextInputType.emailAddress : TextInputType.text,
      obscureText: hintText == 'Password',
      maxLines: maxlines ?? 1,
      decoration: InputDecoration(
          suffixIcon: hintText == "Email"
              ? Icon(Icons.check)
              : Icon(Icons.remove_red_eye),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 0.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0120F1), width: 0.7)),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 10, vertical: maxlines != null ? 10 : 0)),
    );
  }
}
