import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> getExchangeRate(String fromCurrency, String toCurrency) async {
  const apiKey = 'bcef5f750be9a37e6e052c94';
  final url = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/$fromCurrency';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final conversionRates = data['conversion_rates'];
    final rate = conversionRates[toCurrency].toDouble();
    return rate;
  } else {
    throw Exception('Failed to fetch exchange rates');
  }
}
