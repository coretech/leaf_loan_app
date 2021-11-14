import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  static const String routeName = '/articles';

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: const Text('Recent from Leaf'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: ArticlesList(),
      ),
    );
  }
}
