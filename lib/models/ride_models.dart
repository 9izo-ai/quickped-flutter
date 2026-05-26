import 'package:json_annotation/json_annotation.dart';
import 'campus_models.dart';

part 'ride_models.g.dart';

// ==========================
// ACTIVE RIDE MODEL
// ==========================
@JsonSerializable()
class ActiveRide {
  final String id;
  final String userId;
  final String bikeId;
  final String vehicleTypeId;
  final String campusId;
  final String startDockId;
  final DateTime startTime;
  final DateTime startedAt;
  final LockStatus lockStatus; // Current lock state
  final bool isUserLockedTemporarily;
  final String pricingConfigId; // Snapshot of pricing used
  final DateTime createdAt;

  ActiveRide({
    required this.id,
    required this.userId,
    required this.bikeId,
    required this.vehicleTypeId,
    required this.campusId,
    required this.startDockId,
    required this.startTime,
    required this.startedAt,
    required this.lockStatus,
    required this.isUserLockedTemporarily,
    required this.pricingConfigId,
    required this.createdAt,
  });

  factory ActiveRide.fromJson(Map<String, dynamic> json) => _$ActiveRideFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveRideToJson(this);

  // Calculate elapsed time in seconds
  int get elapsedSeconds {
    return DateTime.now().difference(startTime).inSeconds;
  }

  int get elapsedMinutes => (elapsedSeconds / 60).ceil();
}

enum LockStatus {
  @JsonValue('UNLOCKED')
  unlocked,
  @JsonValue('LOCKED')
  locked,
  @JsonValue('TEMPORARY_LOCKED')
  temporaryLocked,
}

// ==========================
// COMPLETED RIDE MODEL
// ==========================
@JsonSerializable()
class CompletedRide {
  final String id;
  final String userId;
  final String bikeId;
  final String vehicleTypeId;
  final String campusId;
  final String startDockId;
  final String endDockId;
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;
  final double distanceKm; // If tracked
  final double fareAmount;
  final String pricingConfigId; // Snapshot used at ride time
  final bool isVerifiedRider; // Role at time of ride
  final DateTime createdAt;
  final DateTime updatedAt;

  CompletedRide({
    required this.id,
    required this.userId,
    required this.bikeId,
    required this.vehicleTypeId,
    required this.campusId,
    required this.startDockId,
    required this.endDockId,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.distanceKm,
    required this.fareAmount,
    required this.pricingConfigId,
    required this.isVerifiedRider,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompletedRide.fromJson(Map<String, dynamic> json) => _$CompletedRideFromJson(json);
  Map<String, dynamic> toJson() => _$CompletedRideToJson(this);
}

// ==========================
// RIDE RECEIPT MODEL
// ==========================
@JsonSerializable()
class RideReceipt {
  final String rideId;
  final String bikeId;
  final String vehicleType;
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;
  final String startDock;
  final String endDock;
  final double distanceKm;
  final double fareAmount;
  final double walletBalanceBefore;
  final double walletBalanceAfter;
  final DateTime generatedAt;

  RideReceipt({
    required this.rideId,
    required this.bikeId,
    required this.vehicleType,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.startDock,
    required this.endDock,
    required this.distanceKm,
    required this.fareAmount,
    required this.walletBalanceBefore,
    required this.walletBalanceAfter,
    required this.generatedAt,
  });

  factory RideReceipt.fromJson(Map<String, dynamic> json) => _$RideReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$RideReceiptToJson(this);
}

// ==========================
// RIDE START REQUEST
// ==========================
@JsonSerializable()
class RideStartRequest {
  final String bikeId;
  final String userId;
  final String campusId;
  final String startDockId;
  final String vehicleTypeId;

  RideStartRequest({
    required this.bikeId,
    required this.userId,
    required this.campusId,
    required this.startDockId,
    required this.vehicleTypeId,
  });

  factory RideStartRequest.fromJson(Map<String, dynamic> json) => _$RideStartRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RideStartRequestToJson(this);
}

// ==========================
// RIDE END REQUEST
// ==========================
@JsonSerializable()
class RideEndRequest {
  final String rideId;
  final String bikeId;
  final String endDockId;
  final double endLatitude;
  final double endLongitude;
  final int durationSeconds;

  RideEndRequest({
    required this.rideId,
    required this.bikeId,
    required this.endDockId,
    required this.endLatitude,
    required this.endLongitude,
    required this.durationSeconds,
  });

  factory RideEndRequest.fromJson(Map<String, dynamic> json) => _$RideEndRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RideEndRequestToJson(this);
}

// ==========================
// RIDE END RESPONSE
// ==========================
@JsonSerializable()
class RideEndResponse {
  final bool success;
  final String? message;
  final RideReceipt? receipt; // If successful
  final String? errorCode; // If failed
  final bool isDockOutOfGeofence; // For validation errors

  RideEndResponse({
    required this.success,
    this.message,
    this.receipt,
    this.errorCode,
    this.isDockOutOfGeofence = false,
  });

  factory RideEndResponse.fromJson(Map<String, dynamic> json) => _$RideEndResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RideEndResponseToJson(this);
}
