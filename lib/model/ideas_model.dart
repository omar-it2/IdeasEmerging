import 'dart:convert';

class IdeasModel {
  int id;
  String title;
  String description;
  String img_link;
  String email;
  IdeasModel restaurantModelFromJson(String str) => IdeasModel.fromJson(json.decode(str));

  String restaurantModelToJson(IdeasModel data) => json.encode(data.toJson());

  IdeasModel({required this.id, required this.title, required this.description, required this.img_link, required this.email});
  factory IdeasModel.fromJson(Map<String, dynamic> json) => IdeasModel(
   id:json['id'], title: json['title'], img_link: json['img_link'], email: json['email'], description: json['description']


  );

  Map<String, dynamic> toJson() => {
    'id':id,
    'title':title,
    "img_link":img_link,
    'description':description,
    'email':email

  };
}
