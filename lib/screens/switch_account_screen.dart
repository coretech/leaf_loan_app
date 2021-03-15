import 'package:flutter/material.dart';
import 'package:loan_app/components/custom_alert_dialog.dart';
import 'package:loan_app/components/custom_dismiss_keyboard.dart';
import 'package:loan_app/components/custom_loading_widget.dart';
import 'package:loan_app/models/server_response.dart';
import 'package:loan_app/models/user.dart';
import 'package:loan_app/providers/auth.dart';
import 'package:loan_app/screens/main_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SwitchAccountScreen extends StatefulWidget {
  static const routeName = '/switch-account';
  const SwitchAccountScreen({Key key}) : super(key: key);

  @override
  _SwitchAccountScreenState createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;

  User _user = User();

  void _saveForm(BuildContext context) async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) return;

    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    final response =
        await Provider.of<AuthLogic>(context, listen: false).login(_user);

    setState(() {
      _isLoading = false;
    });

    if (response.status) {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    } else {
      await showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Login Status',
          text: response.message,
          status: response.status,
          onTap: () => Navigator.of(context).pop(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isFirstTime =
        ModalRoute.of(context).settings.arguments as bool ?? false;

    return Scaffold(
      body: _isLoading
          ? CustomLoadingWidget()
          : Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _form,
              child: CustomDismissKeyboard(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/leaf_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      SizedBox(height: size.height * 0.2),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Welcome to Leaf Loan',
                          style: TextStyle(
                            fontFamily: 'Franklin',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(MdiIcons.account),
                          labelText: 'Username',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter username';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            _user.username = value;
                          });
                        },
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          icon: Icon(MdiIcons.key),
                          labelText: '5-digit PIN',
                        ),
                        obscureText: true,
                        focusNode: _passwordFocusNode,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter 5-digit PIN';
                          } else if (value.length != 5) {
                            return 'Must be a 5-digit PIN';
                          } else if (value == '00000' || value == '12345') {
                            return 'Password must not be 00000 or 12345';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            _user.password = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      RawMaterialButton(
                        fillColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        padding: EdgeInsets.all(15),
                        onPressed: () => _saveForm(context),
                        child: Text('Login'),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                        // onTap: () => Navigator.of(context)
                        //     .pushNamed(ForgotPasswordScreen.routeName),
                      ),
                      SizedBox(height: 10),
                      if (!isFirstTime)
                        GestureDetector(
                          child: Text(
                            'Login to Your Account',
                            style: TextStyle(color: Colors.blue),
                          ),
                          // onTap: () => Navigator.of(context)
                          //     .pushReplacementNamed(LoginScreen.routeName),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
