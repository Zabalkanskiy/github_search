import 'package:flutter/material.dart';
import 'package:search_git_hub/feature/detail_screen/presentation/data/detail_repository.dart';

class DetailRepositoryItem extends StatelessWidget {
  final DetailRepositoryModel repository;

  const DetailRepositoryItem({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: ListTile(
          title: Text(
              repository.name ?? 'No Name',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Center(child: Text("description",  textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Отступ между полями
                child: Text(repository.description ?? 'No Description'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                        text: 'Last updated: ',
                        style: TextStyle(fontWeight: FontWeight.bold), // Жирный шрифт для "Last updated:"
                      ),
                      TextSpan(
                        text: '${repository.updatedAt}',
                      ),
                    ],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Отступ между полями
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                        text: 'Default branch: ',
                        style: TextStyle(fontWeight: FontWeight.bold), // Жирный шрифт для "Default branch:"
                      ),
                      TextSpan(
                        text: '${repository.defaultBranch}',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Отступ между полями
                child: Text('Forks: ${repository.forksCount}'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Отступ между полями
                child: Text('Stars: ${repository.stargazersCount}'),
              ),
              Text('Language: ${repository.language ?? 'Not specified'}'),
            ],
          ),
        ),
      ),
    );
  }
}