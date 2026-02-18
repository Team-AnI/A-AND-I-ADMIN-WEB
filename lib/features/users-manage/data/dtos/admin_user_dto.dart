import 'package:aandi_auth/aandi_auth.dart';

import '../../domain/entities/admin_user.dart';

class AdminUserDto {
  const AdminUserDto({
    required this.id,
    required this.username,
    required this.role,
  });

  factory AdminUserDto.fromJson(Map<String, dynamic> json) {
    return AdminUserDto(
      id: (json['id'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      role: AuthRole.fromApi((json['role'] ?? 'USER').toString()),
    );
  }

  final String id;
  final String username;
  final AuthRole role;

  AdminUser toDomain() {
    return AdminUser(id: id, username: username, role: role);
  }
}
