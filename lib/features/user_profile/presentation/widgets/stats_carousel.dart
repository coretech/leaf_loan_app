import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';
import 'package:loan_app/features/user_profile/presentation/providers/stats_provider.dart';
import 'package:loan_app/features/user_profile/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StatsCarousel extends StatelessWidget {
  const StatsCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StatsProvider>(
      builder: (context, statsProvider, _) {
        if (statsProvider.errorMessage != null) {
          return Center(
            child: Column(
              children: [
                Text(statsProvider.errorMessage!),
                TextButton(
                  child: const Text('Retry'),
                  onPressed: () {
                    statsProvider.getStats();
                  },
                ),
              ],
            ),
          );
        }
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            height: 160,
          ),
          items: _buildItems(statsProvider),
        );
      },
    );
  }

  List<Widget> _buildItems(StatsProvider statsProvider) {
    if (statsProvider.loading) {
      return [
        Shimmer(
          gradient: LinearGradient(
            colors: [
              Colors.grey,
              Colors.grey[200]!,
              Colors.grey[300]!,
              Colors.grey[200]!,
            ],
          ),
          child: const StatCard(
            description: '... .... .... . ... . . . . . .',
            title: '...',
            unit: '',
            value: '0',
          ),
        )
      ];
    }
    if (statsProvider.stats.isEmpty) {
      return [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('No stats available'),
          ],
        )
      ];
    }
    final items = <Widget>[];
    for (final stat in statsProvider.stats) {
      if (stat is MoneyStat) {
        for (final val in (stat.value as Map<String, dynamic>).entries) {
          items.add(
            StatCard(
              description: stat.description,
              title: '${stat.title} (${val.key})',
              unit: val.key,
              value: val.value,
            ),
          );
        }
      } else {
        items.add(
          StatCard(
            description: stat.description,
            title: stat.title,
            unit: '',
            value: stat.value,
          ),
        );
      }
    }
    return items;
  }
}
