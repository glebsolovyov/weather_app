class City{
  final int id;
  final String name;

  const City({
    required this.id,
    required this.name
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name
    };
  }

  @override
  String toString() {
    return "City{id: $id, name: $name}";
  }
}