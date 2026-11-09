import 'package:foodnanny/data/model/quisine_model.dart';
import 'package:foodnanny/data/model/restuarant_model.dart';

RestaurantModel parseAllRestaurant(Map<String, dynamic> json) {
  return RestaurantModel.fromJson(json);
}



QuisineModel parseQuisine(Map<String, dynamic> json) {
  return QuisineModel.fromJson(json);
}
