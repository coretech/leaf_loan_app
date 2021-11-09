import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          const Text(
            'Loading please wait',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
