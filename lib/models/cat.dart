import 'package:dimos_cats/models/enums/cat_tag.dart';

class Cat {
  final String name;
  final bool male;
  final DateTime birthday;
  final String description;
  final String descriptionAr;

  final String historyDescription;
  final String historyDescriptionAr;
  final String? medicalDescription;
  final String? medicalDescriptionAr;

  final String image;
  final List<String> extendedImages;
  final List<CatTag> tags;

  Cat({
    required this.name,
    required this.male,
    required this.birthday,
    required this.image,
    required this.description,
    required this.descriptionAr,
    required this.extendedImages,
    required this.historyDescription,
    required this.historyDescriptionAr,
    this.medicalDescription,
    this.medicalDescriptionAr,

    required this.tags,
  });

  factory Cat.fromJson(
    Map<String, dynamic> json, {
    required String imageRootPath,
  }) {
    return Cat(
      name: json['name'],
      male: json['male'],
      birthday: DateTime.parse(json['birthday']),
      image: "$imageRootPath${json['image']}",
      description: json['description'],
      descriptionAr: json['description_ar'],
      historyDescription: json['historyDescription'],
      historyDescriptionAr: json['historyDescription_ar'],

      medicalDescription: (json['medicalDescription'] as String).isNotEmpty
          ? json['medicalDescription'] as String
          : null,
      medicalDescriptionAr: (json['medicalDescription_ar'] as String).isNotEmpty
          ? json['medicalDescription_ar'] as String
          : null,

      extendedImages: List<String>.from(
        (json['extendedImages'] as List),
      ).map((e) => "$imageRootPath$e").toList(),
      // extendedDescriptions: List<String>.from(
      //   json['extendedDescriptions'] as List,
      // ),
      tags: CatTag.values.where((element) {
        return List<String>.from(json['tags'] as List).contains(element.name);
      }).toList(),
    );
  }

  factory Cat.empty(String name) {
    return Cat(
      name: name,
      male: false,
      birthday: DateTime.now(),
      image: "image-placeholder-$name",
      description: "Test description for $name",
      descriptionAr: "وصف تجريبي لـ $name",
      extendedImages: [],
      historyDescription: "",
      historyDescriptionAr: "",
      medicalDescription: null,
      medicalDescriptionAr: null,
      tags: [CatTag.active, CatTag.active, CatTag.active],
    );
  }

  Cat copyWith({String? name, bool? gender, DateTime? birthday}) {
    return Cat(
      name: name ?? this.name,
      male: gender ?? this.male,
      birthday: birthday ?? this.birthday,
      image: image,
      description: description,
      descriptionAr: descriptionAr,
      extendedImages: extendedImages,
      historyDescription: historyDescription,
      historyDescriptionAr: historyDescriptionAr,
      medicalDescription: medicalDescription,
      medicalDescriptionAr: medicalDescriptionAr,
      tags: tags,
    );
  }
}
