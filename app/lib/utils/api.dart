import 'dart:convert';
import 'package:fitnessapp/view_models/user_view_model.dart';
import 'package:http/http.dart' as http;
 // Import the UserViewModel class

class Api {
  static const String baseUrl = 'http://yourapi.com'; // Replace with your actual API base URL

  // Login API
  static Future<UserViewModel> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/login');  // Adjust path based on your actual route
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Assuming the 'data' contains the user information
      return UserViewModel.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Register API
  static Future<UserViewModel> register(UserViewModel userViewModel) async {
    final url = Uri.parse('$baseUrl/api/register');  // Adjust path based on your actual route
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(userViewModel.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Assuming the 'data' contains the user information
      return UserViewModel.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // Get All Customers API
  static Future<List<UserViewModel>> getAllCustomers() async {
    final url = Uri.parse('$baseUrl/api/getAllCustomers');  // Adjust path based on your actual route
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((customerData) => UserViewModel.fromJson(customerData))
          .toList();
    } else {
      throw Exception('Failed to fetch customers: ${response.body}');
    }
  }
}
