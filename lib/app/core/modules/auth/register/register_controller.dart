import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/modules/services/user/user_service.dart';
import 'package:todo_list_provider/app/exceptions/auth_exception.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required userService}) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        // sucesso
        success = true;
      } else {
        // erro
        error = 'Erro ao registrar o usuario';
      }
      notifyListeners();
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
