import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final double price;
  final double height;
  final double width;
  final int quantity;
  final String woodMaterial;
  final String color;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.height,
    required this.width,
    required this.quantity,
    required this.woodMaterial,
    required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
