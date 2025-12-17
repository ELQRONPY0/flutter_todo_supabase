import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Access to the Supabase client instance
final supabase = Supabase.instance.client;

/// Shows a simple snackbar
extension ShowSnackBar on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }
}
