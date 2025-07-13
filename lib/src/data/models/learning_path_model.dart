import '../../domain/entities/learning_path_entity.dart';

class LearningPathModel extends LearningPathEntity {
  LearningPathModel({
    required int id,
    required String title,
    required String description,
    required bool isCompleted,
  }) : super(
          id: id,
          title: title,
          description: description,
          isCompleted: isCompleted,
        );

  factory LearningPathModel.fromJson(Map<String, dynamic> json) {
    return LearningPathModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
