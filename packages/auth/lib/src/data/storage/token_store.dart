import '../../domain/entities/auth_tokens.dart';

abstract interface class TokenStore {
  Future<void> save(AuthTokens tokens);
  Future<AuthTokens?> read();
  Future<void> clear();
}

final class InMemoryTokenStore implements TokenStore {
  AuthTokens? _tokens;

  @override
  Future<void> save(AuthTokens tokens) async {
    _tokens = tokens;
  }

  @override
  Future<AuthTokens?> read() async => _tokens;

  @override
  Future<void> clear() async {
    _tokens = null;
  }
}
