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

class RealTimeCompassWidgetBefore extends StatefulWidget {
  const RealTimeCompassWidgetBefore({
    super.key,
    this.width,
    this.height,
    required this.userALocation,
    required this.userBLocation,
  });

  final double? width;
  final double? height;
  final LatLng userALocation;
  final LatLng userBLocation;

  @override
  State<RealTimeCompassWidgetBefore> createState() =>
      _RealTimeCompassWidgetBeforeState();
}

class _RealTimeCompassWidgetBeforeState
    extends State<RealTimeCompassWidgetBefore>
    with SingleTickerProviderStateMixin {
  double _bearing = 0.0;
  double _distanceFeet = 0.0;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  double _previousBearing = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _calculateAndStartTracking();
  }

  void _calculateAndStartTracking() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      final from = latlong.LatLng(
        widget.userALocation.latitude,
        widget.userALocation.longitude,
      );
      final to = latlong.LatLng(
        widget.userBLocation.latitude,
        widget.userBLocation.longitude,
      );

      final distanceMeters =
          latlong.Distance().as(latlong.LengthUnit.Meter, from, to);
      final distanceFeet = distanceMeters * 3.28084;

      final dLon =
          (widget.userBLocation.longitude - widget.userALocation.longitude) *
              math.pi /
              180;
      final lat1 = widget.userALocation.latitude * math.pi / 180;
      final lat2 = widget.userBLocation.latitude * math.pi / 180;

      final y = math.sin(dLon) * math.cos(lat2);
      final x = math.cos(lat1) * math.sin(lat2) -
          math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
      double newBearing = math.atan2(y, x);
      newBearing = (newBearing * 180 / math.pi + 360) % 360;

      // Animate rotation
      _rotationAnimation = Tween<double>(
        begin: _previousBearing,
        end: newBearing,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));

      _controller.forward(from: 0);
      _previousBearing = newBearing;

      if (mounted) {
        setState(() {
          _bearing = newBearing;
          _distanceFeet = distanceFeet;
        });

        if (_distanceFeet <= 5) {
          _timer.cancel();
          context.pushNamed('matchFound');
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
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
            animation: _rotationAnimation,
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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
