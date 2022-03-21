import 'package:flutter/material.dart';

import 'package:loan_app/core/presentation/providers/providers.dart';
import 'package:loan_app/features/features.dart';

class LoaderScreen<T> extends StatefulWidget {
  const LoaderScreen({
    Key? key,
    required this.onDone,
    required this.loaderProvider,
  }) : super(key: key);
  final Future<void> Function(T) onDone;
  final LoaderProvider<T> loaderProvider;

  static const String routeName = '/loader';

  @override
  State<LoaderScreen<T>> createState() => _LoaderScreenState<T>();
}

class _LoaderScreenState<T> extends State<LoaderScreen<T>> {
  @override
  void initState() {
    super.initState();
    widget.loaderProvider.addListener(() {
      if (widget.loaderProvider.isDone) {
        widget.onDone(
          widget.loaderProvider.data as T,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoaderArgs<T> {
  LoaderArgs({
    required this.onDone,
    required this.loaderProvider,
  });
  final Future<void> Function(T) onDone;
  final LoaderProvider<T> loaderProvider;
}
