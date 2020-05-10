import 'package:appmobile/bloc/company_bloc.dart';
import 'package:appmobile/model/categories.dart';
import 'package:appmobile/model/company_response.dart';
import 'package:appmobile/view/card_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SearchByName extends StatefulWidget {
  final String searchName;
  SearchByName({this.searchName});
  @override
  State<StatefulWidget> createState() {
    return _SearchByNameState();
  }
}

class _SearchByNameState extends State<SearchByName> {
  CompanyBloc bloc = new CompanyBloc();
  String busca;

  @override
  void initState() {
    super.initState();
    bloc.getCompany();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          //controller: searchController,
       
          onChanged: (newValue) => this.busca = newValue,
          onTap: (){
            Navigator.pop(context);
          },
          // style: widget.textStyle,
          decoration: InputDecoration(
            // icon: widget.icon,
            border: InputBorder.none,
            hintText: widget.searchName,
            // hintStyle: widget.hintStyle,
          ),
        ),
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
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildCompanyWidget(CompanyResponse data) {
  
     return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          //Procurando por nome
           if (data.items[index].fantasyName.toUpperCase().contains(widget.searchName.toUpperCase())){
             return CardCompany(
                  nomeFantasia: data.items[index].fantasyName,
                  descricao: data.items[index].description,
                  image: data.items[index].logo,
                  onPressed: () {},
                  categories: data.items[index].categories);
             
           }
            //Procurando por categoria
           else{
              List<Categories> categories =data.items[index].categories;
              bool result;
              if (categories.isNotEmpty) {
                categories.forEach((element)=> result= element.name.toLowerCase().contains( widget.searchName.toLowerCase()));
                if (result) {
                  return CardCompany(
                      nomeFantasia: data.items[index].fantasyName,
                      descricao: data.items[index].description,
                      image: data.items[index].logo,
                      onPressed: () {},
                      categories: data.items[index].categories);
                } 
          
              }
           }
            
          return SizedBox();
        }
    );
    
  }
}
