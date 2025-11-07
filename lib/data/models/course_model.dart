import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'course_model.g.dart';

@HiveType(typeId: 1)
class CourseModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String teacherId;

  @HiveField(4)
  final String teacherName;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final String thumbnail;

  @HiveField(7)
  final List<String> enrolledStudents;

  @HiveField(8)
  final int totalLessons;

  @HiveField(9)
  final String duration;

  @HiveField(10)
  final DateTime createdAt;

  @HiveField(11)
  final double rating;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.teacherName,
    required this.category,
    required this.thumbnail,
    required this.enrolledStudents,
    required this.totalLessons,
    required this.duration,
    required this.createdAt,
    this.rating = 0.0,
  });

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? teacherId,
    String? teacherName,
    String? category,
    String? thumbnail,
    List<String>? enrolledStudents,
    int? totalLessons,
    String? duration,
    DateTime? createdAt,
    double? rating,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      category: category ?? this.category,
      thumbnail: thumbnail ?? this.thumbnail,
      enrolledStudents: enrolledStudents ?? this.enrolledStudents,
      totalLessons: totalLessons ?? this.totalLessons,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    teacherId,
    category,
    enrolledStudents,
    totalLessons,
  ];
}