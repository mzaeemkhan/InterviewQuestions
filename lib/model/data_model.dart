import 'dart:convert';

DevDataModel devDataModelFromJson(String str) => DevDataModel.fromJson(json.decode(str));

String devDataModelToJson(DevDataModel data) => json.encode(data.toJson());

class DevDataModel {
  DevDataModel({
    required this.category,
  });

  List<Category> category;

  factory DevDataModel.fromJson(Map<String, dynamic> json) => DevDataModel(
    category: json["category"] !=null ? List<Category>.from(json["category"].map((x) => Category.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.categoryName,
    required this.subCategory,
  });

  String categoryName;
  List<SubCategory> subCategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["category_name"] ?? "",
    subCategory:json["sub_category"] != null ? List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategory {
  SubCategory({
    required  this.subCategoryName,
    required   this.juniorLevel,
    required  this.middleLevel,
    required   this.seniorLevel,
    required  this.introduction,
    required  this.icon,
  });

  String subCategoryName;
  List<JuniorLevel> juniorLevel;
  List<JuniorLevel> middleLevel;
  List<JuniorLevel> seniorLevel;
  String introduction;
  String icon;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    subCategoryName: json["sub_category_name"] ?? "",
    juniorLevel:json["junior_level"] != null ? List<JuniorLevel>.from(json["junior_level"].map((x) => JuniorLevel.fromJson(x))):[],
    middleLevel:json["middle_level"]  !=null ? List<JuniorLevel>.from(json["middle_level"].map((x) => x)):[],
    seniorLevel:json["senior_level"] !=null ? List<JuniorLevel>.from(json["senior_level"].map((x) => x)):[],
    introduction: json["introduction"] ?? "",
    icon: json["icon"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "sub_category_name": subCategoryName,
    "junior_level": List<dynamic>.from(juniorLevel.map((x) => x.toJson())),
    "middle_level": List<dynamic>.from(middleLevel.map((x) => x)),
    "senior_level": List<dynamic>.from(seniorLevel.map((x) => x)),
    "introduction": introduction,
    "icon": icon,
  };
}

class JuniorLevel {
  JuniorLevel({
    required  this.q,
    required  this.a,
  });

  String q;
  String a;

  factory JuniorLevel.fromJson(Map<String, dynamic> json) => JuniorLevel(
    q: json["q"] ?? "",
    a: json["a"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "q": q,
    "a": a,
  };
}
