import '../../domain/entities/admin_user.dart';

enum UsersManagementStatus { idle, loading, success, failure }

class UsersManagementState {
  const UsersManagementState({
    required this.status,
    required this.users,
    this.errorMessage,
  });

  const UsersManagementState.initial()
    : status = UsersManagementStatus.idle,
      users = const [],
      errorMessage = null;

  final UsersManagementStatus status;
  final List<AdminUser> users;
  final String? errorMessage;

  UsersManagementState copyWith({
    UsersManagementStatus? status,
    List<AdminUser>? users,
    String? errorMessage,
    bool clearError = false,
  }) {
    return UsersManagementState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
