import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/model/jelly_belly.dart';  // Import the model

class ApiService {
  final String apiUrl = 'https://jellybellywikiapi.onrender.com/api/beans';

  Future<List<JellyBeanModel>> fetchItems() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> items = jsonData['items'];

      // Convert each item in the list to a JellyBeanModel
      return items.map((item) => JellyBeanModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
