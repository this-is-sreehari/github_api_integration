import 'dart:convert';

class UserDetailsModel {
  final String login;
  final int id;
  final String avatarUrl;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final int publicRepos;
  final DateTime createdAt;

  UserDetailsModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    required this.publicRepos,
    required this.createdAt,
  });

  /// Factory method to create an instance from JSON
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      email: json['email'],
      bio: json['bio'],
      publicRepos: json['public_repos'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Method to convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'name': name,
      'company': company,
      'blog': blog,
      'location': location,
      'email': email,
      'bio': bio,
      'public_repos': publicRepos,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Convert JSON string to `UserDetailsModel`
  static UserDetailsModel fromJsonString(String jsonString) {
    return UserDetailsModel.fromJson(json.decode(jsonString));
  }

  /// Convert `UserDetailsModel` to JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
}
