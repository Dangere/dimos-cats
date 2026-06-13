class Cat {
  final String name;
  final bool gender;
  final DateTime birthday;
  final String description;
  final String image;
  final List<String> extendedImages;
  final List<String> extendedDescriptions;

  Cat({
    required this.name,
    required this.gender,
    required this.birthday,
    required this.image,
    required this.description,
    required this.extendedImages,
    required this.extendedDescriptions,
  });

  factory Cat.fromJson(
    Map<String, dynamic> json, {
    required String imageRootPath,
  }) {
    return Cat(
      name: json['name'],
      gender: json['gender'],
      birthday: DateTime.parse(json['birthday']),
      image: "$imageRootPath${json['image']}",
      description: json['description'],
      extendedImages: List<String>.from(
        (json['extendedImages'] as List),
      ).map((e) => "$imageRootPath$e").toList(),
      extendedDescriptions: List<String>.from(
        json['extendedDescriptions'] as List,
      ),
    );
  }
}
