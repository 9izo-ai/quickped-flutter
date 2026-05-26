import 'package:json_annotation/json_annotation.dart';

part 'bike_models.g.dart';

// ==========================
// BIKE STATUS ENUM
// ==========================
enum BikeStatus {
  @JsonValue('AVAILABLE')
  available,
  @JsonValue('IN_RIDE')
  inRide,
  @JsonValue('USER_LOCKED')
  userLocked,
  @JsonValue('MAINTENANCE')
  maintenance,
  @JsonValue('DAMAGED')
  damaged,
}

// ==========================
// BIKE MODEL
// ==========================
@JsonSerializable()
class Bike {
  final String id;
  final String bikeQrCode; // Unique QR code identifier
  final String campusId;
  final String vehicleTypeId;
  final String currentDockId;
  final BikeStatus status;
  final String lockHardwareId; // IoT lock ID
  final double? currentLatitude;
  final double? currentLongitude;
  final int batteryLevel; // 0-100 (%)
  final int totalRides;
  final double totalDistance; // km
  final DateTime lastMaintenanceDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;

  Bike({
    required this.id,
    required this.bikeQrCode,
    required this.campusId,
    required this.vehicleTypeId,
    required this.currentDockId,
    required this.status,
    required this.lockHardwareId,
    this.currentLatitude,
    this.currentLongitude,
    required this.batteryLevel,
    required this.totalRides,
    required this.totalDistance,
    required this.lastMaintenanceDate,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  factory Bike.fromJson(Map<String, dynamic> json) => _$BikeFromJson(json);
  Map<String, dynamic> toJson() => _$BikeToJson(this);

  bool get isAvailable => status == BikeStatus.available;
  bool get isInRide => status == BikeStatus.inRide;
  bool get isUserLocked => status == BikeStatus.userLocked;
  bool get isUnderMaintenance => status == BikeStatus.maintenance;
}

// ==========================
// LOCK STATUS ENUM
// ==========================
enum LockStatus {
  @JsonValue('UNLOCKED')
  unlocked,
  @JsonValue('LOCKED')
  locked,
  @JsonValue('TEMPORARY_LOCKED')
  temporaryLocked,
}

// ==========================
// LOCK STATUS MODEL
// ==========================
@JsonSerializable()
class LockStatusData {
  final String lockHardwareId;
  final LockStatus status;
  final int batteryLevel; // 0-100
  final double? latitude;
  final double? longitude;
  final DateTime lastUpdated;
  final String? errorMessage;

  LockStatusData({
    required this.lockHardwareId,
    required this.status,
    required this.batteryLevel,
    this.latitude,
    this.longitude,
    required this.lastUpdated,
    this.errorMessage,
  });

  factory LockStatusData.fromJson(Map<String, dynamic> json) => _$LockStatusDataFromJson(json);
  Map<String, dynamic> toJson() => _$LockStatusDataToJson(this);
}

// ==========================
// LOCK COMMAND REQUEST/RESPONSE
// ==========================
@JsonSerializable()
class LockCommandRequest {
  final String lockHardwareId;
  final String command; // 'UNLOCK', 'LOCK', 'TEMP_LOCK', 'TEMP_UNLOCK'
  final String? rideId; // For tracking
  final DateTime requestedAt;

  LockCommandRequest({
    required this.lockHardwareId,
    required this.command,
    this.rideId,
    required this.requestedAt,
  });

  factory LockCommandRequest.fromJson(Map<String, dynamic> json) => _$LockCommandRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LockCommandRequestToJson(this);
}

@JsonSerializable()
class LockCommandResponse {
  final bool success;
  final String lockHardwareId;
  final LockStatus newStatus;
  final DateTime confirmedAt;
  final String? message;
  final String? errorCode;

  LockCommandResponse({
    required this.success,
    required this.lockHardwareId,
    required this.newStatus,
    required this.confirmedAt,
    this.message,
    this.errorCode,
  });

  factory LockCommandResponse.fromJson(Map<String, dynamic> json) => _$LockCommandResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LockCommandResponseToJson(this);
}
