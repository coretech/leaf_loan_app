import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return const ArticleCard();
      },
    );
  }
}
