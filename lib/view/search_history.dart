import 'package:appmobile/theme/style.dart';
import 'package:appmobile/view/search_by_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory extends StatefulWidget {
  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  String texto;
  List<String> itens;
  @override
  void initState() {
    someInitMethod();
    super.initState();
  }

  someInitMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      itens = (prefs.getStringList('nome') ?? []);
    });
  }

  addStringToSF(String texto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (texto != null) {
      if (!itens.contains(texto)) {
        setState(() {
          itens.add(texto);
        });
      }
      prefs.setStringList('nome', itens);
    }
  }

  removeValues(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      itens.removeAt(index);
    });
    prefs.setStringList('nome', itens);
  }

  String busca;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          onChanged: (newValue) => this.busca = newValue,
          onSubmitted: (newValue) {
            addStringToSF(busca);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchByName(
                          searchName: newValue,
                        )));
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Pesquisar',
          ),
        ),
      ),
      body: Container(
        // color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            itens.isNotEmpty
                ? Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Pesquisas Recentes',
                          style: TextStyleCustom.title),
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: itens.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color:Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(
                                      Icons.refresh,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(itens[index],
                                      style: TextStyleCustom.title),
                                ],
                              ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchByName(
                                            searchName: itens[index],
                                          )));
                            },
                          ),
                          FlatButton(
                              child: Icon(
                                Icons.clear,
                                color: Color(0xffff6955),
                              ),
                              onPressed: () {
                                removeValues(index);
                              })
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
