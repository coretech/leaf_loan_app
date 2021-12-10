import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({Key? key}) : super(key: key);

  static List<Article> articles = [
    Article(
      description: 'Microlenders provide smaller loan amounts but also offer '
          'support like education and training. Learn how a microloan can '
          'help your business.',
      imageUrl:
          'https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Faofund.org%2Fapp'
          '%2Fuploads%2F2021%2F01%2Fsd_belindamartinez_014-1.jpg',
      title: 'Is a Microloan Right for Me?',
      url: 'https://aofund.org/resource/microloan-right-me/',
    ),
    Article(
      description: 'No matter what the economy is doing in Africa, there is '
          'little that can starve the entrepreneurial spirit of the '
          'continent. So, it is encouraging that aspiring small business '
          'owners have the potential to see a good profit.',
      imageUrl:
          'https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fwww.africa.com'
          '%2Fwp-content%2Fuploads%2F2019%2F07%2FFinding-the-Right-Financing-'
          'for-your-Business.jpg',
      title: 'Finding The Right Financing For Your Business',
      url:
          'https://www.africa.com/finding-the-right-financing-for-your-business/',
    ),
    Article(
      description: "Learn more about Plan International Canada's approach "
          'to microfinance and the 5 benefits to microfinance programs '
          'around the world. ',
      imageUrl:
          'https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fplancanada.ca'
          '%2Fimage%2Fplanv4%2Fabout%2Fwhat-we-do%2Fshare-microfinance.jpg',
      title: '5 Benefits to Microfinance programs',
      url: 'https://plancanada.ca/microfinance-benefits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ArticleCard(
          article: articles[index],
        );
      },
      itemCount: articles.length,
    );
  }
}
