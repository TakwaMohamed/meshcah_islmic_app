import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblaDirectionModel {
  final double direction;
  final double offset;
  final LocationStatus locationStatus;

  QiblaDirectionModel({
    required this.direction,
    required this.offset,
    required this.locationStatus,
  });

  factory QiblaDirectionModel.initial() {
    return QiblaDirectionModel(
      direction: 0,
      offset: 0,
      locationStatus: LocationStatus(false, LocationPermission.denied),
    );
  }
}