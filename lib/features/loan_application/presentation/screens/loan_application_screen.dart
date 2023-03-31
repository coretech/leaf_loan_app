import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({Key? key}) : super(key: key);
  static const String routeName = '/loan-application';

  @override
  _LoanApplicationScreenState createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final _loanTypesProvider = LoanApplicationIOC.loanTypesProvider;
  final _permissionsProvider = LoanApplicationIOC.permissionsProvider;
  final _loanLevelsProvider = CoreIoc.loanLevelProvider;

  @override
  void didChangeDependencies() {
    _permissionsProvider.getPermissionStatus();
    _loanLevelsProvider.fetchForLoggedInUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanTypesProvider,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            title: _getAppBarTitle(),
          ),
          body: _buildContentOrBlocker(),
        );
      },
    );
  }

  Widget _buildContentOrBlocker() {
    return PermissionBuilder(
      onNotAllAllowed: (context, deniedPermissions) {
        return PermissionPrompt(
          permissions: deniedPermissions,
          onPermissionAction: _permissionsProvider.getPermissionStatus,
        );
      },
      onError: (context, message) {
        return CustomErrorWidget(
          message: message,
          onRetry: _permissionsProvider.request,
        );
      },
      onGranted: (context) => _buildContentForLevel(),
      provider: _permissionsProvider,
    );
  }

  Widget _buildContentForLevel() {
    return LoanLevelBuilder(
      loanLevelProvider: _loanLevelsProvider,
      onError: (context, message) {
        return CustomErrorWidget(
          message: message,
          onRetry: () => CoreIoc.loanLevelProvider.fetchForLoggedInUser(),
        );
      },
      onSuccess: (context, level) {
        return _buildForm(level);
      },
    );
  }

  Widget _buildForm(LoanLevel level) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LoanApplicationForm(
              level: level,
              provider: _loanTypesProvider,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getAppBarTitle() {
    return PermissionBuilder(
      onNotAllAllowed: (_, __) => Text('Permissions Not Granted'.tr()),
      onError: (_, __) => Text('Permissions Not Granted'.tr()),
      onGranted: (_) => Text('Apply for a loan'.tr()),
      provider: _permissionsProvider,
    );
  }
}
