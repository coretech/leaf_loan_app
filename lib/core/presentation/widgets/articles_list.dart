import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({Key? key}) : super(key: key);

  static List<Article> articles = [
    Article(
      id: '1',
      description: 'Microlenders provide smaller loan amounts but also offer '
          'support like education and training. Learn how a microloan can '
          'help your business.',
      imageUrl: 'https://s3.us-east-2.amazonaws.com/aofund.org/app/uploads'
          '/2021/01/31010816/sd_belindamartinez_014-1.jpg',
      title: 'Is a Microloan Right for Me?',
      url: 'https://aofund.org/resource/microloan-right-me/',
    ),
    Article(
      id: '2',
      description: 'No matter what the economy is doing in Africa, there is '
          'little that can starve the entrepreneurial spirit of the '
          'continent. So, it is encouraging that aspiring small business '
          'owners have the potential to see a good profit.',
      imageUrl: 'https://www.africa.com/wp-content/uploads/2019/07/'
          'Finding-the-Right-Financing-for-your-Business.jpg',
      title: 'Finding The Right Financing For Your Business',
      url:
          'https://www.africa.com/finding-the-right-financing-for-your-business/',
    ),
    Article(
      id: '3',
      description: "Learn more about Plan International Canada's approach "
          'to microfinance and the 5 benefits to microfinance programs '
          'around the world. ',
      imageUrl:
          'https://plancanada.ca/image/planv4/microfinance/micro-1440.jpg',
      title: '5 Benefits to Microfinance programs',
      url: 'https://plancanada.ca/microfinance-benefits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
