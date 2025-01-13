
class Category{

  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category( {
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    });

  factory Category.fromJson(Map<String,dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'] == null? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null? null : DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'name':name,
      'decription':description,

    };
  }

  Category copyWith(
    {String? id,
    String? name,
    String? description}
    ){
    return Category(
      id: id?? this.id,
      name:name??this.name,
      description: description??this.description,
      );
  }
}