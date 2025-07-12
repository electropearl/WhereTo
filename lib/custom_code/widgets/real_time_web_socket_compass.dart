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

import 'package:flutter_compass/flutter_compass.dart';

import 'dart:math' as math;
import 'dart:async';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RealTimeWebSocketCompass extends StatefulWidget {
  const RealTimeWebSocketCompass({
    super.key,
    required this.userRef,
    required this.peerRef,
    required this.matchRef,
    this.width,
    this.height,
  });

  final DocumentReference userRef;
  final DocumentReference peerRef;
  final DocumentReference matchRef;
  final double? width;
  final double? height;

  @override
  State<RealTimeWebSocketCompass> createState() =>
      _RealTimeWebSocketCompassState();
}

class _RealTimeWebSocketCompassState extends State<RealTimeWebSocketCompass> {
  WebSocketChannel? channel;
  latlong.LatLng? myLoc;
  latlong.LatLng? peerLoc;
  double _distanceFeet = 0.0;
  double _targetBearing = 0.0;
  double _deviceHeading = 0.0;
  bool hasNavigated = false;
  StreamSubscription<Position>? _positionStream;
  StreamSubscription<CompassEvent>? _compassStream;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
    _startLocationStream();
    _listenToCompass();
  }

  void _connectWebSocket() {
    final userId = widget.userRef.id;
    final peerId = widget.peerRef.id;
    final matchId = widget.matchRef.id;

    channel = WebSocketChannel.connect(
      Uri.parse('wss://whereto-osbv.onrender.com'),
    );

    channel!.sink.add(jsonEncode({
      'type': 'register',
      'userId': userId,
    }));

    channel!.sink.add(jsonEncode({
      'type': 'init_match',
      'matchId': matchId,
      'userIds': [userId, peerId],
    }));

    channel!.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['type'] == 'location') {
        peerLoc = latlong.LatLng(data['lat'], data['lng']);
        _updateCompass();
      }
    });
  }

  void _startLocationStream() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((position) {
      myLoc = latlong.LatLng(position.latitude, position.longitude);

      channel?.sink.add(jsonEncode({
        'type': 'location',
        'userId': widget.userRef.id,
        'matchId': widget.matchRef.id,
        'lat': position.latitude,
        'lng': position.longitude,
      }));

      _updateCompass();
    });
  }

  void _listenToCompass() {
    _compassStream = FlutterCompass.events?.listen((event) {
      if (event.heading != null) {
        _deviceHeading = event.heading!;
        _updateCompass();
      }
    });
  }

  void _updateCompass() {
    if (myLoc == null || peerLoc == null) return;

    final distanceMeters =
        latlong.Distance().as(latlong.LengthUnit.Meter, myLoc!, peerLoc!);
    _distanceFeet = distanceMeters * 3.28084;

    final dLon = (peerLoc!.longitude - myLoc!.longitude) * math.pi / 180;
    final lat1 = myLoc!.latitude * math.pi / 180;
    final lat2 = peerLoc!.latitude * math.pi / 180;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    double bearing = math.atan2(y, x);
    _targetBearing = (bearing * 180 / math.pi + 360) % 360;

    if (_distanceFeet <= 5 && !hasNavigated) {
      hasNavigated = true;
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

    setState(() {});
  }

  @override
  void dispose() {
    channel?.sink.close();
    _positionStream?.cancel();
    _compassStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool ready = myLoc != null && peerLoc != null;

    return SizedBox(
      width: widget.width ?? 200,
      height: widget.height ?? 200,
      child: !ready
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12,
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                ),
                Transform.rotate(
                  angle: ((_targetBearing - _deviceHeading) * math.pi) / 180,
                  child: Icon(Icons.navigation, size: 80, color: Colors.red),
                ),
                Positioned(
                  bottom: 10,
                  child: Text(
                    '${_distanceFeet.toStringAsFixed(2)} ft',
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                ),
              ],
            ),
    );
  }
}
