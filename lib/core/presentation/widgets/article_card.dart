import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
  }) : super(key: key);

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
                  const Text(
                    'A small loan just might be what you need',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Struggling to get your bussines up and running? You'
                    " might benefit from Leaf's small loans",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  //button to read the article
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    child: const Text('Read more'),
                    onPressed: () {
                      launch(
                        'https://leafglobalfintech.com/leaf/leaf-for'
                        '-traders-and-small-businesses/',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/small_loan.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
