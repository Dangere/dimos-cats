class Cat {
  final String name;
  final bool gender;
  final DateTime birthDate;
  final String description;
  final String image;
  final List<String> extendedImages;
  final List<String> extendedDescriptions;

  Cat({
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.image,
    required this.description,
    required this.extendedImages,
    required this.extendedDescriptions,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      name: json['name'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),
      image: json['image'],
      description: json['description'],
      extendedImages: json['extendedImages'] as List<String>,
      extendedDescriptions: json['extendedDescriptions'] as List<String>,
    );
  }
}
