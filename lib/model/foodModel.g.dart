// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return FoodModel(
    id: json['id'] as int,
    title: json['title'],
    hotel: json['hotel'],
    price: (json['price'] as num)?.toDouble(),
    imgUrl: json['imgUrl'],
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$FoodModelToJson(FoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hotel': instance.hotel,
      'price': instance.price,
      'imgUrl': instance.imgUrl,
      'quantity': instance.quantity,
    };
