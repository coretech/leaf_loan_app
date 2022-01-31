import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/article.dart';

void main() {
  test(
    'Given values required to make an Article, '
    'When the constructor is called with the values, '
    'Then an instance of Article with the values should be created',
    () {
      final article = Article(
        id: '1',
        title: 'title',
        description: 'description',
        url: 'url',
        imageUrl: 'imageUrl',
      );
      expect(article, isA<Article>());
      expect(article.id, '1');
      expect(article.title, 'title');
      expect(article.description, 'description');
      expect(article.url, 'url');
      expect(article.imageUrl, 'imageUrl');
    },
  );
}
