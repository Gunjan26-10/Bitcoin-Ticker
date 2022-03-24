import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'FE83E4C4-DEA6-4E20-BCB3-7E374347AACC';

class _PriceScreenState extends State<PriceScreen> {

  String currencyType = 'USD';
  var btcRate = '?';
  var ethRate = '?';
  var ltcRate = '?';

  CupertinoPicker iosDrop(){
    List<Text> items = [];
    for(String currency in currenciesList){
      items.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (selectedIndex){

      },
      children: items,
    );
  }



  DropdownButton<String> androidDrop(){
    List<DropdownMenuItem<String>> allItems = [];
    for(int i = 0; i<currenciesList.length; i++){
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      allItems.add(newItem);
    }
    return DropdownButton<String>(
        items: allItems,
        value: currencyType,
        onChanged: (value){
          setState(() {
            currencyType = value;
            getData();
          });
        }
    );
  }

  void getData() async {
    try {
      double btcData = await CoinData('$coinAPIURL/BTC/$currencyType?apikey=$apiKey').getCoinData();
      double ethData = await CoinData('$coinAPIURL/ETH/$currencyType?apikey=$apiKey').getCoinData();
      double ltcData = await CoinData('$coinAPIURL/LTC/$currencyType?apikey=$apiKey').getCoinData();
      setState(() {
        btcRate = btcData.toStringAsFixed(0);
        ethRate = ethData.toStringAsFixed(0);
        ltcRate = ltcData.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(
                  children: [
                    Text(
                      '1 BTC =  $btcRate $currencyType',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '1 ETH =  $ethRate $currencyType',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '1 LTC =  $ltcRate $currencyType',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosDrop() : androidDrop(),
          ),
        ],
      ),
    );
  }
}
