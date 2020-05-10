import 'package:appmobile/model/company_response.dart';
import 'package:appmobile/repository/company_api_provider.dart';

class CompanyRepository{
  CompanyApiProvider _apiProvider = CompanyApiProvider();

  Future<CompanyResponse> getCompany(){
    
    return _apiProvider.getCompany();
  }
}