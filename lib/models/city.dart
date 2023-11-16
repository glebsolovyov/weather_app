class City{
  final String name;

  const City({
    required this.name
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name
    };
  }

  @override
  String toString() {
    return "City{name: $name}";
  }
}