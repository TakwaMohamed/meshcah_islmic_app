import '../../models/qibla_model.dart';

abstract class QiblaState {}

class QiblaInitial extends QiblaState {}
class QiblaLoading extends QiblaState {}
class QiblaLoaded extends QiblaState {
  final QiblaDirectionModel model;
  QiblaLoaded(this.model);
}
class QiblaError extends QiblaState {
  final String message;
  QiblaError(this.message);
}
