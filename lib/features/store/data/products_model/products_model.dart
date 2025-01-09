class ProductsModel {
  String? id;
  String? name;
  String? description;
  int? price;
  List<dynamic>? images;
  String? category;
  String? serviceCenterId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProductsModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.images,
    this.category,
    this.serviceCenterId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'] as int?,
        images: json['images'] as List<dynamic>?,
        category: json['category'] as String?,
        serviceCenterId: json['serviceCenterId'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'price': price,
        'images': images,
        'category': category,
        'serviceCenterId': serviceCenterId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
