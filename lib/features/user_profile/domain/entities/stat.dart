abstract class Stat {
  Stat(this.title, this.description, this.unit, this.value);

  final String title;
  final String description;
  final String unit;
  final dynamic value;
}

class MoneyStat extends Stat {
  MoneyStat({
    required String title,
    required String description,
    required String unit,
    required Map<String, dynamic> value,
  }) : super(title, description, unit, value);
}

class CountStat extends Stat {
  CountStat({
    required String title,
    required String description,
    required String unit,
    required num value,
  }) : super(title, description, unit, value);
}
