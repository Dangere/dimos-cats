import 'package:dimos_cats/models/enums/cat_tag.dart';

class Cat {
  final String name;
  final bool gender;
  final DateTime birthday;
  final String description;
  final String image;
  final List<String> extendedImages;
  final List<String> extendedDescriptions;
  final List<CatTag> tags;

  Cat({
    required this.name,
    required this.gender,
    required this.birthday,
    required this.image,
    required this.description,
    required this.extendedImages,
    required this.extendedDescriptions,
    required this.tags,
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
      tags: CatTag.values.where((element) {
        return List<String>.from(json['tags'] as List).contains(element.name);
      }).toList(),
    );
  }
}
