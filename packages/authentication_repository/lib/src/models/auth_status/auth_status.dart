abstract class AuthStatus {}

class Authenticated extends AuthStatus {
  Authenticated({required this.accessToken});

  final String accessToken;
}

class Unauthenticated extends AuthStatus {
  Unauthenticated({required this.messages, this.forced = false});

  final List<String> messages;
  final bool forced;
}

class AuthUnknown extends AuthStatus {
  AuthUnknown({required this.messages});

  final List<String> messages;
}
