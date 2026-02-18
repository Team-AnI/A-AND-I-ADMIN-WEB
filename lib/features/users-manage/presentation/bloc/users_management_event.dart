sealed class UsersManagementEvent {
  const UsersManagementEvent();
}

class UsersManagementStarted extends UsersManagementEvent {
  const UsersManagementStarted();
}

class UsersManagementRefreshRequested extends UsersManagementEvent {
  const UsersManagementRefreshRequested();
}
