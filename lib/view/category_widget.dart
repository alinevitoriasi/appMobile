import 'package:appmobile/bloc/category_bloc.dart';
import 'package:appmobile/model/category_response.dart';
import 'package:appmobile/theme/style.dart';
import 'package:appmobile/view/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryWidgetState();
  }
}

class _CategoryWidgetState extends State<CategoryWidget> {
  CategoryBloc bloc = new CategoryBloc();
  @override
  void initState() {
    super.initState();
    bloc.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CategoryResponse>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildCategoryWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Buscando dados.."), CircularProgressIndicator()],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Ocorreu um Erro: $error"),
      ],
    ));
  }

  Widget _buildCategoryWidget(CategoryResponse data) {
    return Container(
      height: 130,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.results.length,
          itemBuilder: (context, index) {
            return categoryWidget(
                data.results[index].name, data.results[index].image, () {
              print(data.results[index].name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchByCategory(
                            nomeCategoria: data.results[index].name,
                          )));
            });
          }),
    );
  }
}

categoryWidget(String title, String url_image, Function onPressed) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      FlatButton(
        onPressed: onPressed,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              url_image,
              height: 70,
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: TextStyleCustom.title),
      ),
    ],
  );
}
