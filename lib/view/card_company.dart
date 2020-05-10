import 'package:appmobile/model/categories.dart';
import 'package:appmobile/theme/style.dart';
import 'package:flutter/material.dart';

class CardCompany extends StatelessWidget {

final String nomeFantasia;
final String descricao;
final String image;
final List<Categories> categories;
final Function onPressed;

CardCompany({
    this.nomeFantasia,
    this.descricao,
    this.image,
    this.categories,
    this.onPressed
});
  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: onPressed,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              child: Image.network(
                image,
                height: 95,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(nomeFantasia,style: TextStyleCustom.title),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8),
                  child: listCategories(categories),
                ),
                Text(descricao,style: TextStyleCustom.description),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
    ),
  );
  }

  Widget listCategories(List<Categories> categories){
   return Container(
     height: 20,
     child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return index>0? Text(', '+categories[index].name,style: TextStyleCustom.subtitle):Text(categories[index].name,style: TextStyleCustom.subtitle);
          }),
   );
}
}


