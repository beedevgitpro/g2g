import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:g2g/models/loanDocModel.dart';
import 'package:g2g/utility/pref_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

import '../constants.dart';

class LoanDocController with ChangeNotifier {
  List<LoanDocModel> loanDocList = [];
  Future<List<LoanDocModel>> fetchLoanDocList(String accountID,String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(
        '$apiBaseURL/custom/GetAccountDocuments?AccountID=$accountID&ClientID=${prefs.getString(PrefHelper.Pref_CLIENT_ID)}');
    http.Response response = await http.get(
        '$apiBaseURL/custom/GetAccountDocuments?AccountID=$accountID&ClientID=${prefs.getString(PrefHelper.Pref_CLIENT_ID)}',
        headers: {
          //    'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              'AuthFinWs token="${prefs.getString(PrefHelper.PREF_SESSION_TOKEN)}"'
        });
    print(response.body);
    final myTransformer = Xml2Json();
    myTransformer.parse(response.body);
    String json = myTransformer.toParker();
    print(json);
    var innerJson = jsonDecode(json)['AccountDocs']['Document'];
    loanDocList.clear();
    print(innerJson.runtimeType);
    if(innerJson is List<dynamic>)
      {
        try {
          for (Map m in innerJson)
            loanDocList.add(LoanDocModel.fromJson(m));
        }catch(e){
          print(e);
        }
      }
    else{
  try{
    LoanDocModel m = LoanDocModel.fromJson(innerJson);
    loanDocList.add(m);
  }
  catch(e){
    print(e);
  }
    }


    notifyListeners();
    return loanDocList;
  }

  List<LoanDocModel> get getLoanDocList {
    return [...loanDocList];
  }

  int get listLength {
    return loanDocList.length;
  }
}
