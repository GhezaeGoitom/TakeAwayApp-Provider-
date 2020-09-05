import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foodModel.g.dart';

@JsonSerializable()
class FoodModel {
  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;

  FoodModel(
      {@required this.id,
      @required this.title,
      @required this.hotel,
      @required this.price,
      @required this.imgUrl,
      this.quantity = 1});

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodModelToJson(this);

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
