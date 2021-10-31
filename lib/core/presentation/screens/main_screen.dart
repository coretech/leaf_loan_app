import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPage = 0;
  bool hasLoan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: _getElevation(),
        title: Text(_getTitle()),
      ),
      body: _getPage(),
      bottomNavigationBar: BottomNavBar(
        currentPage: _currentPage,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget _getPage() {
    if (_currentPage == 0) {
      return NewHomeScreen();
      // return HomeScreen(
      //   hasLoan: hasLoan,
      //   onApply: () {
      //     setState(() {
      //       hasLoan = !hasLoan;
      //     });
      //   },
      // );
    } else if (_currentPage == 1) {
      return LoanHistoryScreen(
        hasLoan: hasLoan,
      );
    }
    return Container();
  }

  String _getTitle() {
    if (_currentPage == 0) {
      return "LEAF LOANS";
    } else if (_currentPage == 1) {
      return "LOAN HISTORY";
    }
    return "Other page";
  }

  double? _getElevation() {
    if (_currentPage == 0) {
      return 0;
    }
  }
}
