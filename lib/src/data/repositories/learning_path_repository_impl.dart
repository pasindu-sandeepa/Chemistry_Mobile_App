import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/learning_path_entity.dart';
import '../../domain/repositories/learning_path_repository.dart';
import '../data_sources/local/database_service.dart';
import '../models/learning_path_model.dart';

class LearningPathRepositoryImpl implements LearningPathRepository {
  final DatabaseService databaseService;

  LearningPathRepositoryImpl(this.databaseService);

  @override
  Future<List<LearningPathEntity>> getLearningPaths() async {
    final String response = await rootBundle.loadString('assets/learning_paths.json');
    final List<dynamic> data = jsonDecode(response);
    final paths = data.map((json) => LearningPathModel.fromJson(json)).toList();
    final savedProgress = await databaseService.getLearningPaths();
    return paths.map((path) {
      final savedPath = savedProgress.firstWhere(
        (saved) => saved.id == path.id,
        orElse: () => path,
      );
      return LearningPathModel(
        id: path.id,
        title: path.title,
        description: path.description,
        isCompleted: savedPath.isCompleted,
      );
    }).toList();
  }

  @override
  Future<void> updateLearningPathProgress(int id, bool isCompleted) async {
    await databaseService.updateLearningPathProgress(id, isCompleted);
  }
}