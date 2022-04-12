import 'package:loan_app/core/ioc/ioc.dart';

class ArticlesAnalytics {
  static void articleOpened(String articleId) {
    IntegrationIOC.analytics.logEvent(
      'article_opened',
      parameters: <String, dynamic>{
        'article_id': articleId,
      },
    );
  }
}
