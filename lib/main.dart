import 'package:flutter/material.dart';
import 'package:my_app/networking_service.dart';
//import 'package:my_app/enter_term_page.dart';
import 'enter_term_page.dart';
import 'terms_page.dart';
import 'term.dart';
import 'term_details_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  String _searchedTerm;
  Term _selectedTerm;
  List<Term> _terms = [];

  final _networkingService = NetworkingService();

  void _searchForTerm(String term)  async {
    final terms = await _networkingService.defineTerm(term);

    setState(() {
      this._searchedTerm = term;
      this._terms = terms;
      print(term);
    });
  }

  void _didSelectTerm(Term term){
    setState(() {
      this._selectedTerm = term;
      print(term.word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Dictionary App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigator(
        pages: [
          // show enter term page
          MaterialPage(key: EnterTermPage.valueKey, child: EnterTermPage(searchForTerm: _searchForTerm,)),
          // show terms page if searched term has value
          if(_searchedTerm != null && _searchedTerm.isNotEmpty)
          MaterialPage(key: TermsPage.valueKey,child: TermsPage(
            title: _searchedTerm,
            terms: this._terms,
            didSelectTerm: _didSelectTerm,
          )),
          // show term details page
          if (_selectedTerm != null)
            MaterialPage(
                key: TermDetailsPage.valueKey,
                child: TermDetailsPage(
              term: _selectedTerm,
            ))

        ],
        onPopPage: (route,result){
          final materialPage = route.settings as MaterialPage;
          final pageKey = materialPage.key;

          if (pageKey == TermsPage.valueKey){
            this._searchedTerm = null;
          }

          if (pageKey == TermDetailsPage.valueKey){
            this._selectedTerm = null;
          }

          return route.didPop(result);
        },
      ),
    );
  }
}

