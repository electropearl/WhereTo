// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:math' as math;
import 'package:latlong2/latlong.dart' as latlong;

class RealTimeCompassWidget extends StatefulWidget {
  const RealTimeCompassWidget({
    super.key,
    this.width,
    this.height,
    required this.userADocRef,
    required this.userBDocRef,
    required this.matchRef, // 🔗 Pass match DocumentReference
  });

  final double? width;
  final double? height;
  final DocumentReference userADocRef;
  final DocumentReference userBDocRef;
  final DocumentReference matchRef;

  @override
  State<RealTimeCompassWidget> createState() => _RealTimeCompassWidgetState();
}

class _RealTimeCompassWidgetState extends State<RealTimeCompassWidget>
    with SingleTickerProviderStateMixin {
  double _bearing = 0.0;
  double _distanceFeet = 0.0;
  latlong.LatLng? _userALocation;
  latlong.LatLng? _userBLocation;

  StreamSubscription<Position>? _userAStream;
  StreamSubscription<DocumentSnapshot>? _userBStream;
  Timer? _saveTimer;

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  double _previousBearing = 0.0;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _startLocationTracking();
  }

  void _startLocationTracking() {
    // 📍 High-accuracy location tracking for user A
    _userAStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    ).listen((position) {
      final newLoc = latlong.LatLng(position.latitude, position.longitude);
      setState(() {
        _userALocation = newLoc;
      });
      _updateCompass();
    });

    // 🔁 Save user A location to Firestore every 1 second
    _saveTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (_userALocation != null) {
        await widget.userADocRef.update({
          'location': GeoPoint(
            _userALocation!.latitude,
            _userALocation!.longitude,
          ),
          'latitude': _userALocation!.latitude,
          'longitude': _userALocation!.longitude,
        });
      }
    });

    // 🔁 Listen to updates for user B from Firestore
    _userBStream = widget.userBDocRef.snapshots().listen((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null &&
          data['latitude'] != null &&
          data['longitude'] != null) {
        setState(() {
          _userBLocation = latlong.LatLng(data['latitude'], data['longitude']);
        });
        _updateCompass();
      }
    });
  }

  void _updateCompass() {
    if (_userALocation == null || _userBLocation == null) return;

    final from = _userALocation!;
    final to = _userBLocation!;

    final distanceMeters =
        latlong.Distance().as(latlong.LengthUnit.Meter, from, to);
    final distanceFeet = distanceMeters * 3.28084;

    final dLon = (to.longitude - from.longitude) * math.pi / 180;
    final lat1 = from.latitude * math.pi / 180;
    final lat2 = to.latitude * math.pi / 180;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    double newBearing = math.atan2(y, x);
    newBearing = (newBearing * 180 / math.pi + 360) % 360;

    _rotationAnimation = Tween<double>(
      begin: _previousBearing,
      end: newBearing,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(from: 0);
    _previousBearing = newBearing;

    setState(() {
      _bearing = newBearing;
      _distanceFeet = distanceFeet;
    });

    // 🚀 Navigate when close enough
    if (_distanceFeet <= 5 && !_hasNavigated) {
      _hasNavigated = true;
      context.pushNamed(
        'matchFound',
        queryParameters: {
          'matchRef': widget.matchRef.id,
        },
        extra: {
          'matchRef': widget.matchRef,
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _userAStream?.cancel();
    _userBStream?.cancel();
    _saveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 200,
      height: widget.height ?? 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
              border: Border.all(color: Colors.red, width: 2),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: (_rotationAnimation.value * math.pi) / 180,
                child: child,
              );
            },
            child: Icon(Icons.navigation, size: 80, color: Colors.red),
          ),
          Positioned(
            bottom: 10,
            child: Text(
              '${_distanceFeet.toStringAsFixed(1)} ft',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
