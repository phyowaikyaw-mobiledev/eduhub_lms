import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/course_model.dart';
import '../../data/models/assignment_model.dart';
import '../../data/repositories/course_repository.dart';

// States
abstract class CourseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseModel> courses;
  final List<CourseModel> enrolledCourses;

  CourseLoaded(this.courses, this.enrolledCourses);

  @override
  List<Object?> get props => [courses, enrolledCourses];
}

class CourseError extends CourseState {
  final String message;

  CourseError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _courseRepository;

  CourseCubit(this._courseRepository) : super(CourseInitial());

  void loadCourses({String? studentId}) {
    try {
      final allCourses = _courseRepository.getAllCourses();
      final enrolledCourses = studentId != null
          ? _courseRepository.getEnrolledCourses(studentId)
          : <CourseModel>[];

      emit(CourseLoaded(allCourses, enrolledCourses));
    } catch (e) {
      emit(CourseError('Failed to load courses'));
    }
  }

  Future<void> createCourse({
    required String title,
    required String description,
    required String teacherId,
    required String teacherName,
    required String category,
    required int totalLessons,
    required String duration,
  }) async {
    try {
      await _courseRepository.createCourse(
        title: title,
        description: description,
        teacherId: teacherId,
        teacherName: teacherName,
        category: category,
        totalLessons: totalLessons,
        duration: duration,
      );
      loadCourses();
    } catch (e) {
      emit(CourseError('Failed to create course'));
    }
  }

  Future<void> enrollInCourse(String courseId, String studentId) async {
    try {
      await _courseRepository.enrollStudent(courseId, studentId);
      loadCourses(studentId: studentId);
    } catch (e) {
      emit(CourseError('Failed to enroll in course'));
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await _courseRepository.deleteCourse(courseId);
      loadCourses();
    } catch (e) {
      emit(CourseError('Failed to delete course'));
    }
  }

  List<AssignmentModel> getAssignments(String courseId) {
    return _courseRepository.getAssignmentsByCourse(courseId);
  }

  Future<void> createAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required int totalMarks,
  }) async {
    try {
      await _courseRepository.createAssignment(
        courseId: courseId,
        title: title,
        description: description,
        dueDate: dueDate,
        totalMarks: totalMarks,
      );
    } catch (e) {
      emit(CourseError('Failed to create assignment'));
    }
  }
}