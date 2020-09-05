import 'package:food_delivery/service/foodService.dart';

import '../model/foodModel.dart';

class CartProvider {
  List<FoodModel> foodItems = [];
  FoodRepo foodService = FoodRepo();

  List<FoodModel> addToList(FoodModel foodItem) {
    bool isPresent = false;
    if (foodItems.length > 0) {
      for (int i = 0; i < foodItems.length; i++) {
        if (foodItems[i].id == foodItem.id) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }
    return foodItems;
  }

  void increaseItemQuantity(FoodModel foodItem) => foodItem.incrementQuantity();

  void decreaseItemQuantity(FoodModel foodItem) => foodItem.decrementQuantity();

  List<FoodModel> removeFoodItem(FoodModel foodItem) {
    foodItems.remove(foodItem);
    return foodItems;
  }
}
