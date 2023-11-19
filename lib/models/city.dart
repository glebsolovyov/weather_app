class City{
  final int id;
  final String name;
  final int isSelected;

  const City({
    required this.id,
    required this.name,
    required this.isSelected
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    isSelected: json["isSelected"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "isSelected" : isSelected
    };
  }

  @override
  String toString() {
    return "City{id: $id, name: $name, isSelected: $isSelected}";
  }
}