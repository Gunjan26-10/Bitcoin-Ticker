import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  CoinData(this.uri);

  final uri;

 Future getCoinData() async {
   http.Response response = await http.get(
       Uri.parse(uri),
   );
   if(response.statusCode == 200){
     var data  = jsonDecode(response.body);
     var latestPrice = data['rate'];
     return latestPrice;
   }
 }
}
// v1/exchangerate/BTC?apikey=73034021-FE83E4C4-DEA6-4E20-BCB3-7E374347AACC
// /v1/exchangerate/{asset_id_base}/{asset_id_quote}