import 'package:flutter/material.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required AuthProvider authProvider,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _authProvider = authProvider,
        _usernameController = usernameController,
        _passwordController = passwordController,
        super(key: key);

  final AuthProvider _authProvider;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, bool>(
      selector: (_, provider) => provider.loading,
      builder: (context, loading, _) {
        return ElevatedButton(
          onPressed: !loading
              ? () {
                  _authProvider.login(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  );
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (state) => state.contains(MaterialState.disabled)
                  ? null
                  : Theme.of(context).colorScheme.secondary,
            ),
            fixedSize: MaterialStateProperty.all(
              Size(
                MediaQuery.of(context).size.width * 0.9,
                50,
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              if (loading)
                const SizedBox(
                  width: 10,
                ),
              Text(
                'Log In',
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
