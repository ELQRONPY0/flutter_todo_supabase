import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class SupabaseService {
  // Auth Methods
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  /// Google Sign-In (اختياري)
  /// يتطلب إعداد OAuth في Supabase Dashboard
  /// يرمي استثناءً في حالة الفشل
  Future<void> signInWithGoogle() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.fluttertodo://login-callback/',
      );
    } catch (e) {
      // إعادة رمي الاستثناء مع رسالة أوضح
      if (e.toString().contains('provider is not enabled') ||
          e.toString().contains('Unsupported provider')) {
        throw Exception(
          'Google Sign-In is not enabled. Please enable it in Supabase Dashboard -> Authentication -> Providers -> Google',
        );
      }
      rethrow;
    }
  }

  User? get currentUser => supabase.auth.currentUser;

  // Database Methods

  // Create
  /// إضافة مهمة جديدة
  /// يرمي استثناءً في حالة فشل العملية
  Future<void> addTask(String title, String? description) async {
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }
    try {
      await supabase.from('tasks').insert({
        'user_id': currentUser!.id,
        'title': title,
        'description': description,
        'is_done': false,
      });
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // Stream Read (Real-time)
  /// الحصول على تدفق المهام في الوقت الفعلي
  /// يستخدم Supabase Realtime للاستماع للتغييرات تلقائياً
  Stream<List<Task>> getTasksStream() {
    try {
      return supabase
          .from('tasks')
          .stream(primaryKey: ['id'])
          .order('created_at', ascending: false)
          .map((data) {
            return data.map((taskMap) => Task.fromMap(taskMap)).toList();
          });
    } catch (e) {
      throw Exception('Failed to stream tasks: $e');
    }
  }

  /// الحصول على المهام مع pagination (للحصول على عدد كبير من المهام)
  /// limit: عدد المهام في كل صفحة
  /// offset: عدد المهام المراد تخطيها
  Future<List<Task>> getTasksPaginated({int limit = 50, int offset = 0}) async {
    try {
      final response = await supabase
          .from('tasks')
          .select()
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      return (response as List)
          .map((taskMap) => Task.fromMap(taskMap as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  // Update
  /// تحديث مهمة موجودة
  Future<void> updateTask(Task task) async {
    try {
      await supabase.from('tasks').update({
        'title': task.title,
        'description': task.description,
        'is_done': task.isDone,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', task.id);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  /// تبديل حالة المهمة (مكتملة/غير مكتملة)
  Future<void> toggleTaskStatus(String taskId, bool isDone) async {
    try {
      await supabase.from('tasks').update({
        'is_done': isDone,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to toggle task status: $e');
    }
  }

  // Delete
  /// حذف مهمة
  Future<void> deleteTask(String taskId) async {
    try {
      await supabase.from('tasks').delete().eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
