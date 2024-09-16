import 'package:flutter_qiblah/flutter_qiblah.dart';

abstract class QiblaEvent {}

class LoadQiblaDirection extends QiblaEvent {}
class UpdateQiblaDirection extends QiblaEvent {
  final double direction;
  final double offset;
  UpdateQiblaDirection(this.direction, this.offset);
}
class UpdateLocationStatus extends QiblaEvent {
  final LocationStatus status;
  UpdateLocationStatus(this.status);
}