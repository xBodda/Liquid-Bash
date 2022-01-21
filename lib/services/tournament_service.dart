import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_bash/models/tournament.dart';

class TournamentService extends ChangeNotifier {
  FirebaseFirestore? _instance;
  bool _isLoaded = false;

  final List<Tournament> _tournaments = [];
  List<Tournament> getTorunaments() {
    return _tournaments;
  }

  bool getIsLoaded() {
    return _isLoaded;
  }

  Future<void> getTournamentsCollectionFromFirebase() async {
    if (_tournaments.isNotEmpty) return;
    _instance = FirebaseFirestore.instance;

    CollectionReference tournaments = _instance!.collection("tournaments");
    QuerySnapshot querySnapshot = await tournaments.get();
    final allData = List.from(querySnapshot.docs.map((doc) => doc.data()));
    for (var element in allData) {
      notifyListeners();
      Tournament tournament = Tournament.fromJson(element);
      if (tournament.status != null &&
          tournament.name != null &&
          tournament.date != null &&
          tournament.img != null) _tournaments.add(tournament);
      _isLoaded = true;
    }
  }
}
