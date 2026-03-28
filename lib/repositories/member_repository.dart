import '../models/member_portal_data.dart';

class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;
}

abstract class MemberRepository {
  Future<MemberPortalData> signIn({
    required String identifier,
    required String secret,
  });
}

