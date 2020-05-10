import 'package:appmobile/model/categories.dart';

class Company {
  int id;
  String fantasyName;
  String description;
  int size;
  String logo;
  List<Categories> categories;

  Company(
      {this.id,
      this.fantasyName,
      this.description,
      this.size,
      this.logo,
      this.categories});

  Company.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        fantasyName = json["fantasy_name"],
        description = json["description"],
        size = json["size"],
        logo = json["logo"],
        categories = (json["categories"] as List).map((i) => new Categories.fromJson(i)).toList();

}