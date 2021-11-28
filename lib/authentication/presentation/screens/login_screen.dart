import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider _authProvider;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    _authProvider = AuthProvider();
    _authProvider.addListener(() {
      if (_authProvider.loggedIn && !_authProvider.loading) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      }
      if (!_authProvider.loading && _authProvider.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_authProvider.errorMessage),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _authProvider,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 8,
                    right: 4,
                    top: 8,
                  ),
                  child: Image.asset(
                    'assets/images/leaf_logo_green.png',
                    height: 40,
                  ),
                ),
                Text(
                  'Loans',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          'Welcome!',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 55),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Theme.of(context)
                                    .shadowColor
                                    .withOpacity(0.125),
                                spreadRadius: 5,
                              )
                            ],
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(30),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontSize: 14,
                                      ),
                                  children: [
                                    const TextSpan(text: 'Please enter your '),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _launchApp,
                                      text: 'Leaf Wallet',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: ' credentials.'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Consumer<AuthProvider>(
                                builder: (context, _, __) => Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      AuthTextField(
                                        controller: _usernameController,
                                        hintText: 'Username',
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9a-z@.]'),
                                          ),
                                        ],
                                        keyboardType: TextInputType.name,
                                        suffixIcon: Icons.person,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      AuthTextField(
                                        controller: _passwordController,
                                        hintText: 'Password',
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        keyboardType: TextInputType.number,
                                        obscured: !_passwordVisible,
                                        onSuffixPressed:
                                            _togglePasswordVisibility,
                                        suffixIcon: _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextButton(
                                        onPressed: !_authProvider.loading
                                            ? () {
                                                _authProvider.login(
                                                  username:
                                                      _usernameController.text,
                                                  password:
                                                      _passwordController.text,
                                                );
                                              }
                                            : null,
                                        style: TextButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fixedSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                            50,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 12,
                                          ),
                                          primary: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (_authProvider.loading)
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                            if (_authProvider.loading)
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            const Text(
                                              'Log In',
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color(0xFFA4A4A4)),
                        ),
                        TextButton(
                          onPressed: _launchApp,
                          child: Text(
                            'Sign up on Leaf Wallet',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _launchApp() async {
    await AppLinks.launchApp();
  }
}
