// lib/models/user.dart
import 'dart:convert';

class UserProfile {
  final String gender;
  final String birthdate;
  final String address;

  UserProfile({
    required this.gender,
    required this.birthdate,
    required this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      gender: json['gender'],
      birthdate: json['birthdate'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birthdate': birthdate,
      'address': address,
    };
  }
}

class User {
  final String username;
  final String email;
  final UserProfile profile;

  User({
    required this.username,
    required this.email,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      profile: UserProfile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profile': profile.toJson(),
    };
  }
}
