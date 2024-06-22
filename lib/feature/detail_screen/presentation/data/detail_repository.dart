import 'package:intl/intl.dart';

class DetailRepositoryModel {
  final int? id;
  final String? name;
  final String? description;
  final String? updatedAt;
  final String? defaultBranch;
  final int? forksCount;
  final int? stargazersCount;
  final String? language;

  DetailRepositoryModel({
    this.id,
    this.name,
    this.description,
    this.updatedAt,
    this.defaultBranch,
    this.forksCount,
    this.stargazersCount,
    this.language,
  });

  static String formatDateTime(String dateTime) {
    final dateFormat = DateFormat('yyyy-MM-dd – kk:mm');
    final dateTimeParsed = DateTime.parse(dateTime).toLocal();
    return dateFormat.format(dateTimeParsed);
  }

  factory DetailRepositoryModel.fromJson(Map<String, dynamic> json) {
    return DetailRepositoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      updatedAt: formatDateTime(json['updated_at']),
      defaultBranch: json['default_branch'],
      forksCount: json['forks_count'],
      stargazersCount: json['stargazers_count'],
      language: json['language'],
    );
  }
}