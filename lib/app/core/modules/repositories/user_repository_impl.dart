import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/core/modules/repositories/user_repository.dart';
import 'package:todo_list_provider/app/exceptions/auth_exception.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if(e.code == 'email-already-exists') {
         final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
         if(loginTypes.contains('password')){
          throw AuthException(message: 'E-mail ja utilizado, por favor escolha outro e-mail');
         } else {
          throw AuthException(message: 'Voce se cadastrou no TodoList pelo Google, por favor utilize ele para entrar!');
         }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao cadastrar usuario');
      }
    }
  }
}
