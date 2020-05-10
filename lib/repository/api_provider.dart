import 'package:appmobile/model/category_response.dart';
import 'package:dio/dio.dart';

class CategoryApiProvider{
  final String _endpoint = "http://www.mocky.io/v2/5eac697c330000dc64dfe3db";
  final Dio _dio = Dio();

  Future<CategoryResponse> getCategory() async {
    try {
      Response response = await _dio.get(_endpoint);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CategoryResponse.withError("$error");
    }
  }
}