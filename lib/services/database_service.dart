import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/user.dart';

const String USER_COLLECTION_REF = "users";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final CollectionReference<User> _usersRef;

  DatabaseService() {
    _usersRef = _db.collection(USER_COLLECTION_REF).withConverter(
          fromFirestore: (snapshots, _) => User.fromJson(
            snapshots.data() ?? {}, // Perform a null check here
          ),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  void addUser(User user) async {
    _usersRef.add(user);
  }
}
