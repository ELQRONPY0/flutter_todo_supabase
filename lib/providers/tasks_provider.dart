import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/supabase_service.dart';

/// Provider لإدارة المهام
/// يوفر واجهة للتفاعل مع خدمة Supabase ويتعامل مع حالات التحميل والأخطاء
class TasksProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  // Tasks are primarily managed via StreamBuilder in the UI for real-time updates,
  // but we can expose methods to modify them.

  /// إضافة مهمة جديدة
  Future<void> addTask(String title, String? description) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      await _supabaseService.addTask(title, description);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// تحديث مهمة موجودة
  Future<void> updateTask(Task task) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      await _supabaseService.updateTask(task);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// تبديل حالة المهمة (مكتملة/غير مكتملة)
  Future<void> toggleTaskStatus(String taskId, bool isDone) async {
    try {
      await _supabaseService.toggleTaskStatus(taskId, isDone);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  /// حذف مهمة
  Future<void> deleteTask(String taskId) async {
    try {
      await _supabaseService.deleteTask(taskId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  /// تدفق المهام في الوقت الفعلي (Real-time stream)
  Stream<List<Task>> get tasksStream => _supabaseService.getTasksStream();

  /// إعادة تحميل المهام (لإعادة المحاولة بعد الخطأ)
  void refreshTasks() {
    _error = null;
    notifyListeners();
  }
}
