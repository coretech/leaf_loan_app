import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/articles/ioc/ioc.dart';
import 'package:loan_app/features/articles/presentation/providers/providers.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

/// [ArticlesList] should be wrapped in
/// [ChangeNotifierProvider<ArticlesProvider>]
class ArticlesList extends StatelessWidget {
  const ArticlesList({
    Key? key,
    this.type = ArticleListType.scrollable,
  }) : super(key: key);
  final ArticleListType type;

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticlesProvider>(
      builder: (context, articlesProvider, _) {
        if (articlesProvider.loading) {
          return _buildLoading();
        }
        if (articlesProvider.errorMessage != null) {
          return _buildError(articlesProvider.errorMessage!);
        }

        if (articlesProvider.articles.isEmpty) {
          return _buildNoArticles(context);
        }

        if (type == ArticleListType.scrollable) {
          return _buildScrollable(articlesProvider.articles);
        }

        return _buildNonScrollable(articlesProvider.articles);
      },
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
          ),
          const SizedBox(height: 16),
          TextButton(
            child: Text('Retry'.tr()),
            onPressed: () {
              ArticlesIOC.articlesProvider.getArticles();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNoArticles(BuildContext context) {
    return Center(
      child: Text(
        'No articles found'.tr(),
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildNonScrollable(List<Article> articles) {
    return Column(
      children: articles
          .map(
            (article) => ArticleCard(
              article: article,
            ),
          )
          .toList(),
    );
  }

  Widget _buildScrollable(List<Article> articles) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemBuilder: (context, index) {
        return ArticleCard(
          article: articles[index],
        );
      },
      itemCount: articles.length,
    );
  }
}

enum ArticleListType {
  scrollable,
  nonScrollable,
}
