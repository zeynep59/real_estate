import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/user.dart';
import 'package:real_estate/models/house.dart';
import 'package:real_estate/models/favorites.dart';

const String USER_COLLECTION_REF = "users";
const String HOUSE_COLLECTION_REF = "houses";
const String FAVORITES_COLLECTION_REF = "favorites";

class DatabaseService {

    final FirebaseFirestore _db = FirebaseFirestore.instance;
    late final CollectionReference<User> _usersRef;
    late final CollectionReference<House> _housesRef;
    late final CollectionReference<Favorites> _favoriteRef;

    DatabaseService() {
    _usersRef = _db.collection(USER_COLLECTION_REF).withConverter(
    fromFirestore: (snapshots, _) => User.fromJson(
    snapshots.data() ?? {}, // Perform a null check here
    ),
    toFirestore: (user, _) => user.toJson(),
    );

    _housesRef = _db.collection(HOUSE_COLLECTION_REF).withConverter(
    fromFirestore: (snapshots, _) =>
    House.fromJson(snapshots.data() ?? {}),
    toFirestore: (house, _) => house.toJson(),
    );

    _favoriteRef = _db.collection(FAVORITES_COLLECTION_REF).withConverter(
    fromFirestore: (snapshots, _) =>
    Favorites.fromJson(snapshots.data() ?? {}),
    toFirestore: (favorites, _) => favorites.toJson());
    }

    //CRUD of User

    Stream<QuerySnapshot<User>> getUsers() {
    return _usersRef.snapshots();
    }

    void addUser(User user) async {
    _usersRef.add(user);
    }

    void updateUser(String userId, User user) {
    _usersRef.doc(userId).update(user.toJson());
    }

    void deleteUser(String userId) {
    _usersRef.doc(userId).delete();
    }

    //CRUD of house
    Stream<QuerySnapshot<House>> getHouses() {
    return _housesRef.snapshots();
    }

    void addHouse(House house) async {
    _housesRef.add(house);
    }

    void updateHouse(String houseId, House house) {
    _housesRef.doc(houseId).update(house.toJson());
    }

    void deleteHouse(String houseId) {
    _housesRef.doc(houseId).delete();
    }

    //CRUD of fav
    Stream<QuerySnapshot<Favorites>> getFavorites() {
    return _favoriteRef.snapshots();
    }

    void addFavorite(Favorites favorite) async {
    _favoriteRef.add(favorite);
    }

    void updateFavorite(String favoriteId, Favorites favorite) {
    _favoriteRef.doc(favoriteId).update(favorite.toJson());
    }

    void deleteFavorite(String favoriteId) {
    _favoriteRef.doc(favoriteId).delete();
    }
  }
