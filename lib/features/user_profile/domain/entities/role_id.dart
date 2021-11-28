class RoleId {
  RoleId({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  RoleId copyWith({
    String? id,
    String? name,
  }) {
    return RoleId(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RoleId &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
