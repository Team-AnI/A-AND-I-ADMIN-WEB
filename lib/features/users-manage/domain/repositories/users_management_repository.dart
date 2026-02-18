import '../entities/admin_user.dart';

abstract interface class UsersManagementRepository {
  Future<List<AdminUser>> getUsers();
}
