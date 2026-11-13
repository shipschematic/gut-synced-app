import 'package:get/get.dart';
import 'package:gutsynced/helpers/services/supabase_service.dart';
import 'package:gutsynced/helpers/services/app_config.dart';
import 'package:gutsynced/helpers/services/error_handler.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthController extends GetxController {
  final SupabaseService _supabase = SupabaseService();

  final Rx<AuthStatus> authStatus = AuthStatus.uninitialized.obs;
  final RxString errorMessage = ''.obs;
  final RxString userEmail = ''.obs;

  bool get isAuthenticated => authStatus.value == AuthStatus.authenticated;
  bool get hasSupabase => AppConfig().hasSupabaseConfig;

  @override
  void onInit() {
    super.onInit();
    initAuth();
  }

  Future<void> initAuth() async {
    if (!_supabase.isInitialized) {
      authStatus.value = AuthStatus.unauthenticated;
      return;
    }
    try {
      final session = _supabase.client.auth.currentSession;
      if (session != null) {
        userEmail.value = session.user.email ?? '';
        authStatus.value = AuthStatus.authenticated;
      } else {
        authStatus.value = AuthStatus.unauthenticated;
      }
    } catch (e) {
      authStatus.value = AuthStatus.unauthenticated;
    }
  }

  Future<void> signIn(String email, String password) async {
    authStatus.value = AuthStatus.loading;
    errorMessage.value = '';
    try {
      final response = await _supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      userEmail.value = response.user?.email ?? '';
      authStatus.value = AuthStatus.authenticated;
    } catch (e) {
      errorMessage.value = ErrorHandler.userFriendlyMessage(e);
      authStatus.value = AuthStatus.unauthenticated;
    }
  }

  Future<void> signUp(String email, String password) async {
    authStatus.value = AuthStatus.loading;
    errorMessage.value = '';
    try {
      final response = await _supabase.client.auth.signUp(
        email: email,
        password: password,
      );
      userEmail.value = response.user?.email ?? '';
      authStatus.value = AuthStatus.authenticated;
    } catch (e) {
      errorMessage.value = ErrorHandler.userFriendlyMessage(e);
      authStatus.value = AuthStatus.unauthenticated;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.client.auth.signOut();
    } catch (_) {}
    userEmail.value = '';
    authStatus.value = AuthStatus.unauthenticated;
  }

  void clearError() {
    errorMessage.value = '';
  }
}
