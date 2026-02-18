import '../entities/admin_user.dart';
import '../repositories/users_management_repository.dart';

class GetAdminUsersUseCase {
  const GetAdminUsersUseCase(this._repository);

  final UsersManagementRepository _repository;

  Future<List<AdminUser>> call() => _repository.getUsers();
}
