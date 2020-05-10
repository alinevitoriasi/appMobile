import 'package:appmobile/model/company.dart';
import 'package:appmobile/model/pagination.dart';

class CompanyResponse {
  final List<Company> items;
  final Pagination pagination;

  CompanyResponse(this.items, this.pagination);

  CompanyResponse.fromJson(Map<String, dynamic> json)
      : items =(json["items"] as List).map((i) => new Company.fromJson(i)).toList(),
        pagination = json['pagination'] != null? new Pagination.fromJson(json['pagination']): null;

  CompanyResponse.withError(String errorValue)
      : items = List(),
        pagination = null;
}