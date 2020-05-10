import 'package:appmobile/bloc/company_bloc.dart';
import 'package:appmobile/model/categories.dart';
import 'package:appmobile/model/company_response.dart';
import 'package:appmobile/view/card_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchByCategory extends StatefulWidget {
  final String nomeCategoria;
  SearchByCategory({this.nomeCategoria});
  @override
  State<StatefulWidget> createState() {
    return _SearchByCategoryState();
  }
}

class _SearchByCategoryState extends State<SearchByCategory> {
  CompanyBloc bloc = new CompanyBloc();
  @override
  void initState() {
    super.initState();
    bloc.getCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeCategoria,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<CompanyResponse>(
                stream: bloc.subject.stream,
                builder: (context, AsyncSnapshot<CompanyResponse> snapshot) {
                  if (snapshot.hasData) {
                    return _buildCompanyWidget(snapshot.data);
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                  } else {
                    return _buildLoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Buscando dados..."), CircularProgressIndicator()],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Ocorreu um erro: $error"),
      ],
    ));
  }

  Widget _buildCompanyWidget(CompanyResponse data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          List<Categories> categories =data.items[index].categories;
          bool result;
          
          if (categories.isNotEmpty) {
            
            categories.forEach((element)=> result= element.name == widget.nomeCategoria);
            if (result) {
              return CardCompany(
                  nomeFantasia: data.items[index].fantasyName,
                  descricao: data.items[index].description,
                  image: data.items[index].logo,
                  onPressed: () {},
                  categories: data.items[index].categories);
            } 
            else 
            {
              return SizedBox();
            }
          }
          return SizedBox();
        }
    );
  }
}
