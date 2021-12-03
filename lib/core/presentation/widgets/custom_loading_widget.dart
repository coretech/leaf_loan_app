import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAndroid = Platform.isAndroid;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (isAndroid)
            const CircularProgressIndicator()
          else
            const CupertinoActivityIndicator(),
          const SizedBox(height: 20),
          Text(
            'Loading please wait'.tr(),
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
