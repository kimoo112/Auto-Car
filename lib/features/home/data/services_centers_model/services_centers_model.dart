import 'location.dart';

class ServicesCentersModel {
  Location? location;
  String? id;
  String? name;
  List<dynamic>? services;
  String? contact;
  int? rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ServicesCentersModel({
    this.location,
    this.id,
    this.name,
    this.services,
    this.contact,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ServicesCentersModel.fromJson(Map<String, dynamic> json) {
    return ServicesCentersModel(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      services: json['services'] as List<dynamic>?,
      contact: json['contact'] as String?,
      rating: json['rating'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        '_id': id,
        'name': name,
        'services': services,
        'contact': contact,
        'rating': rating,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  toList() {}
}
