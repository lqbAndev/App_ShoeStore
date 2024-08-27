// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

const String apiUrl = 'http://192.168.1.22:8000/profile/'; // URL của API của bạn

Future<User> fetchUserData(String token) async {
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<void> updateUserData(String token, UserProfile profile) async {
  final response = await http.put(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    },
    body: jsonEncode(profile.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update user data');
  }
}
