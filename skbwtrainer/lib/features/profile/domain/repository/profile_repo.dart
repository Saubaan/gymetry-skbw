import 'package:skbwtrainer/features/profile/domain/entities/gym.dart';

abstract class ProfileRepo {
  Future<Gym> getGym();
  Future<Gym> updateGym(Gym gym);
}