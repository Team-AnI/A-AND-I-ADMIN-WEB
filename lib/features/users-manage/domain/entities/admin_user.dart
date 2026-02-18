import 'package:aandi_auth/aandi_auth.dart';

class AdminUser {
  const AdminUser({
    required this.id,
    required this.username,
    required this.role,
  });

  final String id;
  final String username;
  final AuthRole role;
}
