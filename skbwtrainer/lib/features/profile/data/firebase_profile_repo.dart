import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skbwtrainer/features/profile/domain/entities/gym.dart';

import '../domain/repository/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference gymCollection =
      FirebaseFirestore.instance.collection('gym');

  @override
  Future<Gym> getGym() async {
    try {
      // Get gym document from the gym collection
      DocumentSnapshot gymDoc = await gymCollection.doc('SKBW').get();
      if (gymDoc.exists) {
        return Gym.fromJson(gymDoc.data() as Map<String, dynamic>);
      } else {
        throw Exception('Gym not found');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Gym> updateGym(Gym gym) async{
    try {
      // Update gym document in the gym collection
      await gymCollection.doc('SKBW').update(gym.toJson());
      return gym;
    } catch (e) {
      throw Exception(e);
    }
  }
}
