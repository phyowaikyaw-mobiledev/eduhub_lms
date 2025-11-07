import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'assignment_model.g.dart';

@HiveType(typeId: 2)
class AssignmentModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String courseId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime dueDate;

  @HiveField(5)
  final int totalMarks;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final Map<String, dynamic>? submission;

  const AssignmentModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.totalMarks,
    required this.createdAt,
    this.submission,
  });

  AssignmentModel copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    DateTime? dueDate,
    int? totalMarks,
    DateTime? createdAt,
    Map<String, dynamic>? submission,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      totalMarks: totalMarks ?? this.totalMarks,
      createdAt: createdAt ?? this.createdAt,
      submission: submission ?? this.submission,
    );
  }

  @override
  List<Object?> get props => [id, courseId, title, dueDate, totalMarks];
}