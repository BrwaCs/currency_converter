import 'package:currency_converter/Api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double conversionRate = 0.0;
  double amount = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  Future<void> fetchExchangeRate() async {
    setState(() {
      isLoading = true;
    });

    try {
      final rate = await getExchangeRate(fromCurrency, toCurrency);
      setState(() {
        conversionRate = rate;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch exchange rates.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void convertAmount(String value) {
    setState(() {
      amount = double.tryParse(value) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Currency Converter')),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blue)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: fromCurrency,
                            onChanged: (value) {
                              setState(() {
                                fromCurrency = value!;
                                fetchExchangeRate();
                              });
                            },
                            items: [
                              'USD',
                              'EUR',
                              'GBP',
                              'IQD',
                              'AUD',
                              'CAD',
                              'JPY',
                              'HKD',
                              'CHF',
                              'SEK',
                              'ILS'
                            ].map((currency) {
                              return DropdownMenuItem<String>(
                                value: currency,
                                child: Text(
                                  currency,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Text(
                        "TO",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blue)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: toCurrency,
                            onChanged: (value) {
                              setState(() {
                                toCurrency = value!;
                                fetchExchangeRate();
                              });
                            },
                            items: [
                              'USD',
                              'EUR',
                              'GBP',
                              'IQD',
                              'AUD',
                              'CAD',
                              'JPY',
                              'HKD',
                              'CHF',
                              'SEK',
                              'ILS'
                            ].map((currency) {
                              return DropdownMenuItem<String>(
                                value: currency,
                                child: Text(
                                  currency,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Container(
                    width: 370,
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: convertAmount,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Converted Amount : ${(amount * conversionRate).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
