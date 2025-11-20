class Exercise {
  final String name;
  final int sets;
  final String reps;
  final String rest;
  final String description;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.description,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json["name"],
      sets: json["sets"],
      reps: json["reps"],
      rest: json["rest"],
      description: json["description"],
    );
  }
}