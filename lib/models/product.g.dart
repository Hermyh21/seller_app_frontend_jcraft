// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      woodMaterial: json['woodMaterial'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'height': instance.height,
      'width': instance.width,
      'quantity': instance.quantity,
      'woodMaterial': instance.woodMaterial,
      'color': instance.color,
    };
