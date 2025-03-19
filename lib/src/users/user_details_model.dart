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
}

class UserRepository {
  final String name;
  final String url;

  UserRepository({
    required this.name,
    required this.url
  });

  factory UserRepository.fromJson(Map<String, dynamic> json) {
    return UserRepository(
      name: json['name'] ?? '',
      url: json['url'] ?? ''
    );
  }
}
