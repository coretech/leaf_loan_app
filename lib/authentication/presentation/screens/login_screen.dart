import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/presentation/screens/screens.dart';
import 'package:loan_app/i18n/i18n.dart';
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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();

  bool _passwordVisible = false;

  @override
  void initState() {
    Smartlook.setRenderingMode(SmartlookRenderingMode.no_rendering);
    _authProvider = AuthProvider()
      ..loadUsername()
      ..addListener(_authProviderListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authProvider,
      builder: (context, _) {
        return Scaffold(
          appBar: _buildAppBar(context),
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
                          'Welcome!'.tr(),
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 55,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        _buildAuthCard(context),
                        const Spacer(),
                        Text(
                          "Don't have an account?".tr(),
                          style: const TextStyle(color: Color(0xFFA4A4A4)),
                        ),
                        TextButton(
                          onPressed: () {
                            AuthenticationAnalytics.logSignUpTapped();
                            _launchApp();
                          },
                          child: Text(
                            'Sign up on Leaf Wallet'.tr(),
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

  Widget _buildAuthCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).shadowColor.withOpacity(0.125),
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
          _buildLeafWalletPrompt(context),
          const SizedBox(
            height: 15,
          ),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Consumer<AuthProvider>(
      builder: (context, _, __) => Form(
        key: _formKey,
        child: Column(
          children: [
            AuthTextField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              hintText: 'Username'.tr(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp('[0-9a-z@.]'),
                ),
              ],
              suffixIcon: Icons.person,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            AuthTextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              hintText: 'Password'.tr(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp('[0-9]'),
                ),
              ],
              keyboardType: TextInputType.number,
              obscured: !_passwordVisible,
              onSuffixPressed: _togglePasswordVisibility,
              onSubmit: _login,
              suffixIcon:
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
              textInputAction: TextInputAction.go,
            ),
            const SizedBox(
              height: 15,
            ),
            SubmitButton(
              authProvider: _authProvider,
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeafWalletPrompt(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontSize: 14,
            ),
        children: [
          TextSpan(text: 'Please enter your'.tr()),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AuthenticationAnalytics.logLeafWalletButtonTapped();
                _launchApp();
              },
            text: ' ${'Leaf Wallet'.tr()} ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: 'credentials.'.tr()),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      toolbarHeight: 85,
      title: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Row(
          children: const [
            LeafLoansLogo(),
            Spacer(),
            LanguageDropdown(location: 'login_screen')
          ],
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _launchApp() async {
    await ExternalLinks.launchApp();
  }

  void _login() {
    _authProvider.login(
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }

  void _authProviderListener() {
    if (_authProvider.initialLoad && _authProvider.username.isNotEmpty) {
      _usernameController.text = _authProvider.username;
    }
    if (_authProvider.loggedIn && !_authProvider.loading) {
      AuthenticationAnalytics.logSignIn(
        _usernameController.text,
        'Leaf Wallet Credentials',
      );

      Smartlook.setRenderingMode(SmartlookRenderingMode.native);

      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
    }
    if (!_authProvider.loading && _authProvider.errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_authProvider.errorMessage.tr()),
        ),
      );
    }
  }
}
