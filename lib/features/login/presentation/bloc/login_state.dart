enum LoginSubmissionStatus { idle, submitting, success, failure }

class LoginState {
  const LoginState({
    required this.username,
    required this.password,
    required this.submissionStatus,
    this.errorMessage,
  });

  const LoginState.initial()
    : username = '',
      password = '',
      submissionStatus = LoginSubmissionStatus.idle,
      errorMessage = null;

  final String username;
  final String password;
  final LoginSubmissionStatus submissionStatus;
  final String? errorMessage;

  bool get canSubmit =>
      username.trim().isNotEmpty && password.trim().isNotEmpty;

  LoginState copyWith({
    String? username,
    String? password,
    LoginSubmissionStatus? submissionStatus,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
