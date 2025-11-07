import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';

class UserRepository {
  final Box<UserModel> _userBox = Hive.box<UserModel>('users');
  final Box _settingsBox = Hive.box('settings');
  final _uuid = const Uuid();

  // Register new user
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      // Check if email already exists
      final existingUser = _userBox.values.firstWhere(
            (user) => user.email == email,
        orElse: () => UserModel(
          id: '',
          name: '',
          email: '',
          password: '',
          role: '',
          createdAt: DateTime.now(),
        ),
      );

      if (existingUser.id.isNotEmpty) {
        return null; // Email already exists
      }

      final user = UserModel(
        id: _uuid.v4(),
        name: name,
        email: email,
        password: password,
        role: role,
        createdAt: DateTime.now(),
      );

      await _userBox.put(user.id, user);
      return user;
    } catch (e) {
      return null;
    }
  }

  // Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final user = _userBox.values.firstWhere(
            (user) => user.email == email && user.password == password,
        orElse: () => UserModel(
          id: '',
          name: '',
          email: '',
          password: '',
          role: '',
          createdAt: DateTime.now(),
        ),
      );

      if (user.id.isNotEmpty) {
        await _settingsBox.put('currentUserId', user.id);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Get current user
  UserModel? getCurrentUser() {
    final userId = _settingsBox.get('currentUserId');
    if (userId != null) {
      return _userBox.get(userId);
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    await _settingsBox.delete('currentUserId');
  }

  // Update user
  Future<void> updateUser(UserModel user) async {
    await _userBox.put(user.id, user);
  }

  // Get all users by role
  List<UserModel> getUsersByRole(String role) {
    return _userBox.values.where((user) => user.role == role).toList();
  }

  // Get user by ID
  UserModel? getUserById(String id) {
    return _userBox.get(id);
  }
}