import 'package:appmobile/bloc/company_bloc.dart';
import 'package:appmobile/model/company_response.dart';
import 'package:appmobile/view/card_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompanyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompanyWidgetState();
  }
}

class _CompanyWidgetState extends State<CompanyWidget> {

  CompanyBloc bloc = new CompanyBloc();
  @override
  void initState() {
    super.initState();
    bloc.getCompany();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompanyResponse>(
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
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          return CardCompany(
              nomeFantasia: data.items[index].fantasyName,
              descricao: data.items[index].description,
              image: data.items[index].logo,
              onPressed: () {},
              categories: data.items[index].categories);
        });
  }
}

