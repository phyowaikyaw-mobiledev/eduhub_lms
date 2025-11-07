import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/course_model.dart';
import '../models/assignment_model.dart';

class CourseRepository {
  final Box<CourseModel> _courseBox = Hive.box<CourseModel>('courses');
  final Box<AssignmentModel> _assignmentBox = Hive.box<AssignmentModel>('assignments');
  final _uuid = const Uuid();

  Future<CourseModel> createCourse({
    required String title,
    required String description,
    required String teacherId,
    required String teacherName,
    required String category,
    required int totalLessons,
    required String duration,
  }) async {
    final course = CourseModel(
      id: _uuid.v4(),
      title: title,
      description: description,
      teacherId: teacherId,
      teacherName: teacherName,
      category: category,
      thumbnail: _getRandomThumbnail(category),
      enrolledStudents: [],
      totalLessons: totalLessons,
      duration: duration,
      createdAt: DateTime.now(),
      rating: 0.0,
    );

    await _courseBox.put(course.id, course);
    return course;
  }

  List<CourseModel> getAllCourses() {
    return _courseBox.values.toList();
  }

  List<CourseModel> getCoursesByTeacher(String teacherId) {
    return _courseBox.values
        .where((course) => course.teacherId == teacherId)
        .toList();
  }

  List<CourseModel> getEnrolledCourses(String studentId) {
    return _courseBox.values
        .where((course) => course.enrolledStudents.contains(studentId))
        .toList();
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    final course = _courseBox.get(courseId);
    if (course != null && !course.enrolledStudents.contains(studentId)) {
      final updatedCourse = course.copyWith(
        enrolledStudents: [...course.enrolledStudents, studentId],
      );
      await _courseBox.put(courseId, updatedCourse);
    }
  }

  Future<AssignmentModel> createAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required int totalMarks,
  }) async {
    final assignment = AssignmentModel(
      id: _uuid.v4(),
      courseId: courseId,
      title: title,
      description: description,
      dueDate: dueDate,
      totalMarks: totalMarks,
      createdAt: DateTime.now(),
    );

    await _assignmentBox.put(assignment.id, assignment);
    return assignment;
  }

  List<AssignmentModel> getAssignmentsByCourse(String courseId) {
    return _assignmentBox.values
        .where((assignment) => assignment.courseId == courseId)
        .toList();
  }

  CourseModel? getCourseById(String courseId) {
    return _courseBox.get(courseId);
  }

  Future<void> updateCourse(CourseModel course) async {
    await _courseBox.put(course.id, course);
  }

  Future<void> deleteCourse(String courseId) async {
    await _courseBox.delete(courseId);

    final assignments = getAssignmentsByCourse(courseId);
    for (var assignment in assignments) {
      await _assignmentBox.delete(assignment.id);
    }
  }

  String _getRandomThumbnail(String category) {
    const thumbnails = {
      'Programming': '💻',
      'Design': '🎨',
      'Business': '💼',
      'Mathematics': '🔢',
      'Science': '🔬',
      'Language': '🗣️',
    };
    return thumbnails[category] ?? '📚';
  }

  Future<void> initializeSampleData(String teacherId, String teacherName) async {
    if (_courseBox.isEmpty) {
      await createCourse(
        title: 'Flutter Development Masterclass',
        description: 'Learn Flutter from scratch to advanced level',
        teacherId: teacherId,
        teacherName: teacherName,
        category: 'Programming',
        totalLessons: 45,
        duration: '12 weeks',
      );

      await createCourse(
        title: 'UI/UX Design Fundamentals',
        description: 'Master the principles of user interface design',
        teacherId: teacherId,
        teacherName: teacherName,
        category: 'Design',
        totalLessons: 30,
        duration: '8 weeks',
      );

      await createCourse(
        title: 'Data Structures & Algorithms',
        description: 'Complete DSA course for interviews',
        teacherId: teacherId,
        teacherName: teacherName,
        category: 'Programming',
        totalLessons: 60,
        duration: '16 weeks',
      );
    }
  }
}