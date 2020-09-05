import 'package:food_delivery/model/foodModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const MY_FOOD_ITEMS_URL = 'http://192.168.1.8:3000/posts';

class FoodRepo {
  Future<List<FoodModel>> getFoodItem() async {
    final result = await http.Client().get(MY_FOOD_ITEMS_URL);

    if (result.statusCode != 200) throw Exception();
    List<dynamic> foodItems = jsonDecode(result.body);
    print(foodItems);
    // List<dynamic> foodItems = FoodItems[""];
    return foodItems.map((json) => FoodModel.fromJson(json)).toList();
  }
}
