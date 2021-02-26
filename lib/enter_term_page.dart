import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// class EnterTermVC: StatefulWidget{
class EnterTermPage extends StatefulWidget{
  static final valueKey = ValueKey('EnterTermPage');

  EnterTermPage({Key key,this.searchForTerm}) : super(key: key);

  final ValueChanged<String> searchForTerm;

  @override
  State<StatefulWidget> createState() =>_EnterTermPageState();
}


class _EnterTermPageState extends State<EnterTermPage>{

  final _textFieldController = TextEditingController();

  void _search(){
    widget.searchForTerm(_textFieldController.text);
  }

  Widget searchForm(){
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(labelText: 'Enter term'),
              ),
              FlatButton(
                  onPressed: () => _search(),
                  color: Colors.redAccent ,
                  textColor: Colors.white,
                  child: Text('Search'))
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Urban Dictionary'),),
      body: searchForm(),
      );
  }
}