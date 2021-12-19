import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/features/articles/articles.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //bolder text to show the article title
                  Text(
                    article.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.description,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  //button to read the article
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text('Read more'.tr()),
                    onPressed: () {
                      ArticlesAnalytics.articleOpened(article.id);
                      launch(
                        article.url,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              article.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              // loadingBuilder: (context, child, loadingProgress) {
              //   return const SizedBox(
              //     height: 80,
              //     width: 80,
              //     child: Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //   );
              // },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/small_loan.jpg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
