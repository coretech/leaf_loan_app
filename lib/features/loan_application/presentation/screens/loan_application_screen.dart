import 'package:flutter/material.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';
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
  late LoanTypeProvider _loanTypeProvider;
  int _selectedCurrencyIndex = 0;
  int _selectedLoanTypeIndex = 0;
  int _selectedDurationInDays = 60;
  String? _selectedPurpose;
  double? _loanAmount;
  int currentStep = 0;
  int currentPage = 0;

  final _remoteConfig = IntegrationIOC.remoteConfig;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loanTypeProvider = LoanApplicationIOC.loanTypeProvider
      ..addListener(_loanApplicationListener)
      ..init()
      ..getLoanTypes();
    _pageController.addListener(_pageControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanTypeProvider,
      builder: (context, _) {
        return Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                title: Text(_getAppBarTitle()),
              ),
              body: _buildContentOrBlocker(),
            );
          },
        );
      },
    );
  }

  Widget _buildContentOrBlocker() {
    if (!_loanTypeProvider.permissionsGranted) {
      return PermissionPrompt(
        denied: _loanTypeProvider.deniedPermissions,
      );
    }
    
    return _buildContent();
  }

  Widget _buildContent() {
    if (_remoteConfig
            .getString(RemoteConfigKeys.formContentType)
            .toLowerCase() ==
        'a') {
      return FormContentA(
        loanAmount: _loanAmount,
        onCurrencySelected: _onCurrencySelected,
        onDurationInDaysSelected: _onDurationInDaysSelected,
        onLoanTypeSelected: _onLoanTypeSelected,
        onPurposeSelected: _onPurposeSelected,
        onSubmitPressed: _onSubmitPressed,
        selectedPurpose: _selectedPurpose,
        selectedCurrencyIndex: _selectedCurrencyIndex,
        selectedDurationInDays: _selectedDurationInDays,
        selectedLoanTypeIndex: _selectedLoanTypeIndex,
        onLoanAmountChanged: _onLoanAmountChanged,
      );
    } else if (_remoteConfig
            .getString(RemoteConfigKeys.formContentType)
            .toLowerCase() ==
        'b') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FormContentB(
                loanAmount: _loanAmount,
                onCurrencySelected: _onCurrencySelected,
                onDurationInDaysSelected: _onDurationInDaysSelected,
                onLoanTypeSelected: _onLoanTypeSelected,
                onPurposeSelected: _onPurposeSelected,
                onSubmitPressed: _onSubmitPressed,
                selectedPurpose: _selectedPurpose,
                selectedCurrencyIndex: _selectedCurrencyIndex,
                selectedDurationInDays: _selectedDurationInDays,
                selectedLoanTypeIndex: _selectedLoanTypeIndex,
                onLoanAmountChanged: _onLoanAmountChanged,
                controller: _pageController,
              ),
            ),
          ),
          StepIndicator(
            total: 5,
            pageController: _pageController,
          ),
          NavButtons(
            pageController: _pageController,
            onSubmit: _onSubmitPressed,
            onNext: _onNext,
            onPrev: _onPrev,
          )
        ],
      );
    } else {
      return FormContentC(
        currentStep: currentStep,
        loanAmount: _loanAmount,
        selectedCurrencyIndex: _selectedCurrencyIndex,
        selectedLoanTypeIndex: _selectedLoanTypeIndex,
        selectedDurationInDays: _selectedDurationInDays,
        selectedPurpose: _selectedPurpose,
        onPurposeSelected: _onPurposeSelected,
        onLoanAmountChanged: _onLoanAmountChanged,
        onLoanTypeSelected: _onLoanTypeSelected,
        onCurrencySelected: _onCurrencySelected,
        onDurationInDaysSelected: _onDurationInDaysSelected,
        onNextPressed: _onStepperNext,
        onBackPressed: _onOnStepperBack,
        onSubmitPressed: _onSubmitPressed,
      );
    }
  }

  void _onStepperNext() {
    if (_canGoNext(currentStep)) {
      setState(() {
        currentStep++;
      });
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (!_amountIsValid() && currentPage == 3) {
      showSnackbar('Loan amount is invalid!'.tr());
    } else if (!_hasValidCurrencies()) {
      showSnackbar('You need at least one currency to proceed'.tr());
    }
  }

  void _onOnStepperBack() {
    setState(() {
      currentStep--;
    });
  }

  bool _canGoNext([int? current]) {
    current ??= currentPage;
    return (_amountIsValid() || current != 3) &&
        (_hasValidCurrencies() || current != 1);
  }

  void _onNext() {
    if (_canGoNext()) {
      setState(() {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      });
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (!_amountIsValid() && currentPage == 3) {
      showSnackbar('Loan amount is invalid!'.tr());
    } else if (!_hasValidCurrencies()) {
      showSnackbar('You need at least one currency to proceed'.tr());
    }
  }

  void _onPrev() {
    setState(() {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _onPurposeSelected(String purpose) {
    setState(() {
      _selectedPurpose = purpose;
    });
  }

  void _onLoanAmountChanged(double? loanAmount) {
    setState(() {
      _loanAmount = loanAmount;
    });
  }

  void _onLoanTypeSelected(int value) {
    final selectedLoan = _loanTypeProvider.loanTypes[value];
    setState(() {
      _selectedLoanTypeIndex = value;
      if (selectedLoan.hasCurrencies) {
        _selectedCurrencyIndex = 0;
        _loanAmount =
            selectedLoan.currencies[_selectedCurrencyIndex].minLoanAmount;
      }
    });
  }

  void _onCurrencySelected(int value) {
    setState(() {
      _selectedCurrencyIndex = value;
      _loanAmount = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
          .currencies[_selectedCurrencyIndex].minLoanAmount;
    });
  }

  void _onDurationInDaysSelected(int durationInDays) {
    setState(() {
      _selectedDurationInDays = durationInDays;
    });
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _onSubmitPressed() {
    if (_canSubmit()) {
      _onSubmit();
    } else {
      if (!_hasValidCurrencies()) {
        showSnackbar('You need at least one currency to proceed'.tr());
      } else if (_loanAmount == null) {
        showSnackbar('Please select loan amount!'.tr());
      } else if (_selectedPurpose == null) {
        showSnackbar('Please select loan purpose!'.tr());
      } else if (_selectedDurationInDays < 60) {
        showSnackbar('Please select a proper loan duration!'.tr());
      }
    }
  }

  bool _canSubmit() {
    return _loanTypeProvider.canShowTypes &&
        _amountIsValid() &&
        _selectedPurpose != null;
  }

  bool _amountIsValid([double? amount]) {
    amount ??= _loanAmount;
    if (_loanTypeProvider.errorMessage != null) {
      return false;
    }
    final currentLoan = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex];
    if (currentLoan.hasCurrencies) {
      final selectedCurrency = currentLoan.currencies[_selectedCurrencyIndex];
      return amount != null &&
          amount <= selectedCurrency.maxLoanAmount &&
          amount >= selectedCurrency.minLoanAmount;
    }
    return false;
  }

  bool _hasValidCurrencies() {
    if (_loanTypeProvider.errorMessage != null) {
      return false;
    }
    final currentLoan = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex];
    return currentLoan.hasCurrencies;
  }

  String _getAppBarTitle() {
    if (_loanTypeProvider.permissionsGranted) {
      return 'Apply for a loan'.tr();
    }
    return 'Permissions Not Granted'.tr();
  }

  void showAmountErrorSnackbar() {
    showSnackbar('Please select a proper loan amount'.tr());
  }

  Future<void> _onSubmit() async {
    LoanApplicationAnalytics.loanApplicationSubmitButtonTapped();
    final success = await showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => LoanConfirmationWidget(
        amount: _loanAmount!,
        durationDays: _selectedDurationInDays,
        loanType: _loanTypeProvider.loanTypes[_selectedLoanTypeIndex],
        purpose: _selectedPurpose!,
        selectedCurrency: _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex],
      ),
    );
    if (success ?? false) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loan application submitted successfully'.tr()),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  void _loanApplicationListener() {
    if (_loanTypeProvider.loanTypes.isNotEmpty && mounted) {
      final selectedLoan = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex];
      setState(() {
        if (selectedLoan.hasCurrencies) {
          _loanAmount =
              selectedLoan.currencies[_selectedCurrencyIndex].minLoanAmount;
        }
      });
    }
  }

  void _pageControllerListener() {
    final controller = _pageController;
    if (controller.page != null && controller.page!.round() != currentPage) {
      setState(() {
        currentPage = controller.page!.round();
      });
    }
  }
}
