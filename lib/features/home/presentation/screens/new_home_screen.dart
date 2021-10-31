import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 75,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoanHistoryScreen.routeName);
              },
              icon: Icon(
                Icons.history,
                color: _getAppBarTextColor(context),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Leaf Loans',
                  style: TextStyle(
                    color: _getAppBarTextColor(context),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_outlined,
                color: _getAppBarTextColor(context),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrentLoanInfo(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: LoanActionButtons(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Recent Transactions",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: Center(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    PaymentCard(),
                    PaymentCard(),
                    PaymentCard(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoanDetailScreen(
                              dueDate: DateTime.now(),
                              paidAmount: 234325,
                              status: LoanStatus.due,
                              totalAmount: 10234324,
                            ),
                          ),
                        );
                      },
                      child: Text("show more"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAppBarTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Formatter.formatDate(DateTime.now()),
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.75,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 2.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.75,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'KSH ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: '12,960',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoanActionButtons extends StatelessWidget {
  const LoanActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Text("Apply for a loan"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            fixedSize: MaterialStateProperty.all(Size(150, 70)),
            foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onSurface),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        TextButton(
          onPressed: () {},
          child: Text("Pay your debts"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            fixedSize: MaterialStateProperty.all(Size(150, 70)),
            foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onSurface),
          ),
        )
      ],
    );
  }
}

class CurrentLoanInfo extends StatelessWidget {
  const CurrentLoanInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoanDetailScreen(
              dueDate: DateTime.now(),
              paidAmount: 234325,
              status: LoanStatus.due,
              totalAmount: 10234324,
            ),
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Stack(
          children: [
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.black.withOpacity(0.25),
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "Pay before",
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "January 15, 2022",
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Remaining Amount",
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'KSH ',
                          style: TextStyle(
                            color: _getTextColor(context),
                          ),
                        ),
                        TextSpan(
                          text: '12,960',
                          style: TextStyle(
                            color: _getTextColor(context),
                            fontSize: 31.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.info,
                    color: _getTextColor(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }
}
