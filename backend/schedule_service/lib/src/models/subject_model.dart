class Subject {
  final int id;
  final String name;

  Subject({required this.id, required this.name});

  Subject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
