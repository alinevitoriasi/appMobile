import 'package:appmobile/model/category_response.dart';
import 'package:appmobile/repository/api_provider.dart';

class CategoryRepository{
  CategoryApiProvider _apiProvider = CategoryApiProvider();

  Future<CategoryResponse> getCategory(){
    
    return _apiProvider.getCategory();
  }
}