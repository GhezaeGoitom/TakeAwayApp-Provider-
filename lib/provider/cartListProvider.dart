import 'package:flutter/foundation.dart';
import 'package:food_delivery/model/foodModel.dart';
import 'package:food_delivery/provider/cartProvider.dart';
import 'package:food_delivery/service/foodService.dart';

class CartListProvider extends ChangeNotifier {
  var _foodLists = List<FoodModel>();

  List<FoodModel> getFoodItems() {
    getAllFoodItems();
    return _foodLists;
  }

  void getAllFoodItems() async {
    _foodLists = await foodService.getFoodItem();
  }

  CartProvider _provider = CartProvider();
  FoodRepo foodService = FoodRepo();

//for adding food to the list
  void addToList(FoodModel foodItem) =>
      {_provider.addToList(foodItem), notifyListeners()};

//for removing food from the list
  void removeFromList(FoodModel foodItem) =>
      {_provider.removeFoodItem(foodItem), notifyListeners()};
}
