import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _interestedInGoing = prefs
              .getStringList('ff_interestedInGoing')
              ?.map((path) => path.ref)
              .toList() ??
          _interestedInGoing;
    });
    _safeInit(() {
      _locations = prefs
              .getStringList('ff_locations')
              ?.map((path) => path.ref)
              .toList() ??
          _locations;
    });
    _safeInit(() {
      _filterRadius = prefs.getDouble('ff_filterRadius') ?? _filterRadius;
    });
    _safeInit(() {
      _sortedVenues = prefs
              .getStringList('ff_sortedVenues')
              ?.map((path) => path.ref)
              .toList() ??
          _sortedVenues;
    });
    _safeInit(() {
      _friend =
          prefs.getStringList('ff_friend')?.map((path) => path.ref).toList() ??
              _friend;
    });
    _safeInit(() {
      _venueFilter = prefs.getStringList('ff_venueFilter') ?? _venueFilter;
    });
    _safeInit(() {
      _vibeFilter = prefs.getStringList('ff_vibeFilter') ?? _vibeFilter;
    });
    _safeInit(() {
      _matches =
          prefs.getStringList('ff_matches')?.map((path) => path.ref).toList() ??
              _matches;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<DocumentReference> _interestedInGoing = [];
  List<DocumentReference> get interestedInGoing => _interestedInGoing;
  set interestedInGoing(List<DocumentReference> value) {
    _interestedInGoing = value;
    prefs.setStringList(
        'ff_interestedInGoing', value.map((x) => x.path).toList());
  }

  void addToInterestedInGoing(DocumentReference value) {
    interestedInGoing.add(value);
    prefs.setStringList(
        'ff_interestedInGoing', _interestedInGoing.map((x) => x.path).toList());
  }

  void removeFromInterestedInGoing(DocumentReference value) {
    interestedInGoing.remove(value);
    prefs.setStringList(
        'ff_interestedInGoing', _interestedInGoing.map((x) => x.path).toList());
  }

  void removeAtIndexFromInterestedInGoing(int index) {
    interestedInGoing.removeAt(index);
    prefs.setStringList(
        'ff_interestedInGoing', _interestedInGoing.map((x) => x.path).toList());
  }

  void updateInterestedInGoingAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    interestedInGoing[index] = updateFn(_interestedInGoing[index]);
    prefs.setStringList(
        'ff_interestedInGoing', _interestedInGoing.map((x) => x.path).toList());
  }

  void insertAtIndexInInterestedInGoing(int index, DocumentReference value) {
    interestedInGoing.insert(index, value);
    prefs.setStringList(
        'ff_interestedInGoing', _interestedInGoing.map((x) => x.path).toList());
  }

  List<DocumentReference> _locations = [];
  List<DocumentReference> get locations => _locations;
  set locations(List<DocumentReference> value) {
    _locations = value;
    prefs.setStringList('ff_locations', value.map((x) => x.path).toList());
  }

  void addToLocations(DocumentReference value) {
    locations.add(value);
    prefs.setStringList('ff_locations', _locations.map((x) => x.path).toList());
  }

  void removeFromLocations(DocumentReference value) {
    locations.remove(value);
    prefs.setStringList('ff_locations', _locations.map((x) => x.path).toList());
  }

  void removeAtIndexFromLocations(int index) {
    locations.removeAt(index);
    prefs.setStringList('ff_locations', _locations.map((x) => x.path).toList());
  }

  void updateLocationsAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    locations[index] = updateFn(_locations[index]);
    prefs.setStringList('ff_locations', _locations.map((x) => x.path).toList());
  }

  void insertAtIndexInLocations(int index, DocumentReference value) {
    locations.insert(index, value);
    prefs.setStringList('ff_locations', _locations.map((x) => x.path).toList());
  }

  double _filterRadius = 0.0;
  double get filterRadius => _filterRadius;
  set filterRadius(double value) {
    _filterRadius = value;
    prefs.setDouble('ff_filterRadius', value);
  }

  bool _showFullList = false;
  bool get showFullList => _showFullList;
  set showFullList(bool value) {
    _showFullList = value;
  }

  List<DocumentReference> _sortedVenues = [];
  List<DocumentReference> get sortedVenues => _sortedVenues;
  set sortedVenues(List<DocumentReference> value) {
    _sortedVenues = value;
    prefs.setStringList('ff_sortedVenues', value.map((x) => x.path).toList());
  }

  void addToSortedVenues(DocumentReference value) {
    sortedVenues.add(value);
    prefs.setStringList(
        'ff_sortedVenues', _sortedVenues.map((x) => x.path).toList());
  }

  void removeFromSortedVenues(DocumentReference value) {
    sortedVenues.remove(value);
    prefs.setStringList(
        'ff_sortedVenues', _sortedVenues.map((x) => x.path).toList());
  }

  void removeAtIndexFromSortedVenues(int index) {
    sortedVenues.removeAt(index);
    prefs.setStringList(
        'ff_sortedVenues', _sortedVenues.map((x) => x.path).toList());
  }

  void updateSortedVenuesAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    sortedVenues[index] = updateFn(_sortedVenues[index]);
    prefs.setStringList(
        'ff_sortedVenues', _sortedVenues.map((x) => x.path).toList());
  }

  void insertAtIndexInSortedVenues(int index, DocumentReference value) {
    sortedVenues.insert(index, value);
    prefs.setStringList(
        'ff_sortedVenues', _sortedVenues.map((x) => x.path).toList());
  }

  List<DocumentReference> _friend = [];
  List<DocumentReference> get friend => _friend;
  set friend(List<DocumentReference> value) {
    _friend = value;
    prefs.setStringList('ff_friend', value.map((x) => x.path).toList());
  }

  void addToFriend(DocumentReference value) {
    friend.add(value);
    prefs.setStringList('ff_friend', _friend.map((x) => x.path).toList());
  }

  void removeFromFriend(DocumentReference value) {
    friend.remove(value);
    prefs.setStringList('ff_friend', _friend.map((x) => x.path).toList());
  }

  void removeAtIndexFromFriend(int index) {
    friend.removeAt(index);
    prefs.setStringList('ff_friend', _friend.map((x) => x.path).toList());
  }

  void updateFriendAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    friend[index] = updateFn(_friend[index]);
    prefs.setStringList('ff_friend', _friend.map((x) => x.path).toList());
  }

  void insertAtIndexInFriend(int index, DocumentReference value) {
    friend.insert(index, value);
    prefs.setStringList('ff_friend', _friend.map((x) => x.path).toList());
  }

  List<String> _venueFilter = [];
  List<String> get venueFilter => _venueFilter;
  set venueFilter(List<String> value) {
    _venueFilter = value;
    prefs.setStringList('ff_venueFilter', value);
  }

  void addToVenueFilter(String value) {
    venueFilter.add(value);
    prefs.setStringList('ff_venueFilter', _venueFilter);
  }

  void removeFromVenueFilter(String value) {
    venueFilter.remove(value);
    prefs.setStringList('ff_venueFilter', _venueFilter);
  }

  void removeAtIndexFromVenueFilter(int index) {
    venueFilter.removeAt(index);
    prefs.setStringList('ff_venueFilter', _venueFilter);
  }

  void updateVenueFilterAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    venueFilter[index] = updateFn(_venueFilter[index]);
    prefs.setStringList('ff_venueFilter', _venueFilter);
  }

  void insertAtIndexInVenueFilter(int index, String value) {
    venueFilter.insert(index, value);
    prefs.setStringList('ff_venueFilter', _venueFilter);
  }

  List<String> _vibeFilter = [];
  List<String> get vibeFilter => _vibeFilter;
  set vibeFilter(List<String> value) {
    _vibeFilter = value;
    prefs.setStringList('ff_vibeFilter', value);
  }

  void addToVibeFilter(String value) {
    vibeFilter.add(value);
    prefs.setStringList('ff_vibeFilter', _vibeFilter);
  }

  void removeFromVibeFilter(String value) {
    vibeFilter.remove(value);
    prefs.setStringList('ff_vibeFilter', _vibeFilter);
  }

  void removeAtIndexFromVibeFilter(int index) {
    vibeFilter.removeAt(index);
    prefs.setStringList('ff_vibeFilter', _vibeFilter);
  }

  void updateVibeFilterAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    vibeFilter[index] = updateFn(_vibeFilter[index]);
    prefs.setStringList('ff_vibeFilter', _vibeFilter);
  }

  void insertAtIndexInVibeFilter(int index, String value) {
    vibeFilter.insert(index, value);
    prefs.setStringList('ff_vibeFilter', _vibeFilter);
  }

  List<DocumentReference> _matches = [];
  List<DocumentReference> get matches => _matches;
  set matches(List<DocumentReference> value) {
    _matches = value;
    prefs.setStringList('ff_matches', value.map((x) => x.path).toList());
  }

  void addToMatches(DocumentReference value) {
    matches.add(value);
    prefs.setStringList('ff_matches', _matches.map((x) => x.path).toList());
  }

  void removeFromMatches(DocumentReference value) {
    matches.remove(value);
    prefs.setStringList('ff_matches', _matches.map((x) => x.path).toList());
  }

  void removeAtIndexFromMatches(int index) {
    matches.removeAt(index);
    prefs.setStringList('ff_matches', _matches.map((x) => x.path).toList());
  }

  void updateMatchesAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    matches[index] = updateFn(_matches[index]);
    prefs.setStringList('ff_matches', _matches.map((x) => x.path).toList());
  }

  void insertAtIndexInMatches(int index, DocumentReference value) {
    matches.insert(index, value);
    prefs.setStringList('ff_matches', _matches.map((x) => x.path).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
