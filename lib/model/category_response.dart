import 'package:appmobile/model/category.dart';

class CategoryResponse {
  final List<Category> results;


  CategoryResponse(this.results, );

  CategoryResponse.fromJson(Map<String, dynamic> json)
      : results =
            (json["items"] as List).map((i) => new Category.fromJson(i)).toList();

  CategoryResponse.withError(String errorValue)
      : results = List();
    
}