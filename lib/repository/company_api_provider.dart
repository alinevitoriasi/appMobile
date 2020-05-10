import 'package:appmobile/model/company_response.dart';
import 'package:dio/dio.dart';

class CompanyApiProvider {
  final String _endpoint = "http://www.mocky.io/v2/5eac692c3300003941dfe3d8";
  Dio _dio= Dio();


  Future<CompanyResponse> getCompany() async {
    try {
      Response response = await _dio.get(_endpoint);
      return CompanyResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CompanyResponse.withError("$error");
    }
  }
}