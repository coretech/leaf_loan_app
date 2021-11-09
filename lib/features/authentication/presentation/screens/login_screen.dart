import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/core/utils/utils.dart';

import 'package:loan_app/features/authentication/authentication.dart';
import 'package:loan_app/features/home/home.dart';
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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const NewHomeScreen();
            },
          ),
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
      builder: (context, _) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/leaf_logo_white.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to Leaf Loans!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'Please login to continue',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              onSuffixPressed: _togglePasswordVisibility,
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
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                      );
                                    }
                                  : null,
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.9,
                                  50,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 12,
                                ),
                                primary:
                                    Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_authProvider.loading)
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color(0xFFA4A4A4)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            await AppLinks.launchApp();
                          },
                          child: Text(
                            'Sign up on Leaf Wallet',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
