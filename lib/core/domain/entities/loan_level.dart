class LoanLevel {
  LoanLevel({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;

  LoanLevel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return LoanLevel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
