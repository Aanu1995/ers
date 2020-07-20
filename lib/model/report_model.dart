import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String state;
  final int confirmed;
  final int active;
  final int discharged;
  final int death;
  final double latitude;
  final double longitude;

  Report({
    this.state,
    this.latitude,
    this.longitude,
    this.confirmed,
    this.active,
    this.discharged,
    this.death,
  });

  factory Report.fromMap(value) {
    final map = value ?? {};
    final confirmed = map["confirmed"] ?? 0;
    final discharged = map["recovered"] ?? 0;
    final dead = map['dead'] ?? 0;
    return Report(
      state: map['location'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      confirmed: confirmed,
      discharged: discharged,
      death: dead,
      active: confirmed > 0 ? (confirmed - (discharged + dead)) : 0,
    );
  }

  @override
  List<Object> get props => [
        state,
        latitude,
        longitude,
        confirmed,
        discharged,
        death,
        active,
      ];
}
