import 'package:aandi_auth/aandi_auth.dart';

import '../../domain/entities/admin_user_provision_type.dart';

sealed class UsersManagementEvent {
  const UsersManagementEvent();
}

class UsersManagementStarted extends UsersManagementEvent {
  const UsersManagementStarted();
}

class UsersManagementRefreshRequested extends UsersManagementEvent {
  const UsersManagementRefreshRequested();
}

class UsersManagementCreateRequested extends UsersManagementEvent {
  const UsersManagementCreateRequested({
    required this.role,
    required this.provisionType,
  });

  final AuthRole role;
  final AdminUserProvisionType provisionType;
}
