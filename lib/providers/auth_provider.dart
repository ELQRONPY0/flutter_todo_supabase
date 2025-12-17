import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  User? get user => _supabaseService.currentUser;

  // Listen to auth state changes
  void initialize() {
    supabase.auth.onAuthStateChange.listen((data) {
      notifyListeners();
    });
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _supabaseService.signIn(email, password);
    } on AuthException catch (e) {
      // معالجة أفضل لرسائل الخطأ
      String errorMessage = e.message;
      bool showResendOption = false;

      if (e.message.contains('email_not_confirmed') ||
          e.message.contains('Email not confirmed')) {
        errorMessage =
            'Please confirm your email first. Check your inbox or click to resend.';
        showResendOption = true;
      }

      if (showResendOption) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Resend',
              textColor: Colors.white,
              onPressed: () {
                resendConfirmationEmail(email, context);
              },
            ),
          ),
        );
      } else {
        context.showSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await _supabaseService.signUp(email, password);

      // التحقق من حالة تأكيد البريد الإلكتروني
      if (response.user != null && response.session == null) {
        // المستخدم أنشئ ولكن لم يتم تأكيد البريد
        context.showSnackBar(
          'Registration successful! Please check your email to confirm your account.',
          isError: false,
        );
      } else {
        context.showSnackBar('Registration successful! Please sign in.');
      }
    } on AuthException catch (e) {
      // معالجة أفضل لرسالة الخطأ
      String errorMessage = e.message;
      if (e.message.contains('email_not_confirmed') ||
          e.message.contains('Email not confirmed')) {
        errorMessage = 'Please confirm your email first. Check your inbox.';
      }
      context.showSnackBar(errorMessage, isError: true);
    } catch (e) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// إعادة إرسال رابط تأكيد البريد الإلكتروني
  Future<void> resendConfirmationEmail(
      String email, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      context.showSnackBar('Confirmation email sent! Check your inbox.');
    } on AuthException catch (e) {
      context.showSnackBar(e.message, isError: true);
    } catch (e) {
      context.showSnackBar('Failed to send confirmation email', isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _supabaseService.signOut();
    notifyListeners();
  }

  /// Google Sign-In (اختياري)
  /// يفتح نافذة المتصفح للمصادقة
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _supabaseService.signInWithGoogle();
      // Note: المصادقة ستحدث عبر redirect URL - إذا فتحت المتصفح فهذا نجاح
    } on AuthException catch (e) {
      String errorMessage = e.message;
      // رسالة خطأ أوضح للمستخدم
      if (e.message.contains('provider is not enabled') ||
          e.message.contains('Unsupported provider')) {
        errorMessage =
            'Google Sign-In is not enabled in Supabase. Please enable it in Dashboard -> Authentication -> Providers -> Google';
        // عرض Dialog مع تعليمات
        _showGoogleSignInErrorDialog(context, errorMessage);
      } else {
        context.showSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      String errorMsg = e.toString();
      if (errorMsg.contains('provider is not enabled') ||
          errorMsg.contains('Unsupported provider')) {
        _showGoogleSignInErrorDialog(
          context,
          'Google Sign-In is not enabled. Please enable it in Supabase Dashboard.',
        );
      } else {
        context.showSnackBar('Error: ${e.toString()}', isError: true);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showGoogleSignInErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange),
            SizedBox(width: 12),
            Text('Google Sign-In Not Enabled'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 16),
            const Text(
              'To enable Google Sign-In:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('1. Go to Supabase Dashboard'),
            const Text('2. Navigate to Authentication → Providers'),
            const Text('3. Enable Google provider'),
            const Text('4. Add OAuth credentials from Google Cloud Console'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
