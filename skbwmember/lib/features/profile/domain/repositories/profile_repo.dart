import 'package:skbwmember/features/member/domain/entities/member.dart';

abstract class ProfileRepo {
  Future<Member> getProfile();
  Future<Member> updateProfile(Member member);
}