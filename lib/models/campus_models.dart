import 'package:json_annotation/json_annotation.dart';

part 'campus_models.g.dart';

// ==========================
// CAMPUS MODEL
// ==========================
@JsonSerializable()
class Campus {
  final String id;
  final String name;
  final String country;
  final String city;
  final String mapImageUrl; // URL to campus map asset
  final List<Dock> docks;
  final List<VehicleType> vehicleTypes;
  final PricingConfig pricingConfig;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? colorPrimary; // Campus branding color
  final String? colorSecondary;

  Campus({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.mapImageUrl,
    required this.docks,
    required this.vehicleTypes,
    required this.pricingConfig,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.colorPrimary,
    this.colorSecondary,
  });

  factory Campus.fromJson(Map<String, dynamic> json) => _$CampusFromJson(json);
  Map<String, dynamic> toJson() => _$CampusToJson(this);
}

// ==========================
// DOCK MODEL
// ==========================
@JsonSerializable()
class Dock {
  final String id;
  final String campusId;
  final String name;
  final double latitude;
  final double longitude;
  final int capacity; // Total slots
  final double geofenceRadius; // in meters
  final int availableBikes; // Real-time count
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Dock({
    required this.id,
    required this.campusId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.capacity,
    required this.geofenceRadius,
    required this.availableBikes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Dock.fromJson(Map<String, dynamic> json) => _$DockFromJson(json);
  Map<String, dynamic> toJson() => _$DockToJson(this);

  // Helper to get coordinates
  get coordinates => LatLng(latitude: latitude, longitude: longitude);
}

// ==========================
// VEHICLE TYPE MODEL
// ==========================
@JsonSerializable()
class VehicleType {
  final String id;
  final String campusId;
  final String name; // e.g., 'eBike', 'Scooter', 'Bike'
  final String displayLabel; // e.g., 'Electric Bike'
  final String iconUrl; // URL to vehicle icon
  final String lockHardwareType; // e.g., 'MOBIKE', 'OFO', 'GENERIC'
  final FareStructure fareStructure;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  VehicleType({
    required this.id,
    required this.campusId,
    required this.name,
    required this.displayLabel,
    required this.iconUrl,
    required this.lockHardwareType,
    required this.fareStructure,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) => _$VehicleTypeFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleTypeToJson(this);
}

// ==========================
// FARE STRUCTURE MODEL
// ==========================
@JsonSerializable()
class FareStructure {
  final double baseFare; // Starting fare amount
  final int baseDuration; // Minutes included in base fare
  final double perMinuteRate; // Rate after base duration
  final double verifiedRiderDiscount; // Discount % for verified riders
  final double guestRiderMultiplier; // Multiplier for guest riders

  FareStructure({
    required this.baseFare,
    required this.baseDuration,
    required this.perMinuteRate,
    required this.verifiedRiderDiscount,
    required this.guestRiderMultiplier,
  });

  factory FareStructure.fromJson(Map<String, dynamic> json) => _$FareStructureFromJson(json);
  Map<String, dynamic> toJson() => _$FareStructureToJson(this);

  // Calculate fare based on duration and user role
  double calculateFare(int durationMinutes, {bool isVerifiedRider = true}) {
    double fare = baseFare;

    if (durationMinutes > baseDuration) {
      int extraMinutes = durationMinutes - baseDuration;
      fare += extraMinutes * perMinuteRate;
    }

    // Apply role-based adjustments
    if (isVerifiedRider) {
      fare -= fare * (verifiedRiderDiscount / 100);
    } else {
      fare *= guestRiderMultiplier;
    }

    return fare;
  }
}

// ==========================
// PRICING CONFIG MODEL
// ==========================
@JsonSerializable()
class PricingConfig {
  final String id;
  final String campusId;
  final double minimumWalletBalance; // Required to start a ride
  final Map<String, FareStructure> vehicleTypeFares; // Fare by vehicle type ID
  final DateTime effectiveFrom;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  PricingConfig({
    required this.id,
    required this.campusId,
    required this.minimumWalletBalance,
    required this.vehicleTypeFares,
    required this.effectiveFrom,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PricingConfig.fromJson(Map<String, dynamic> json) => _$PricingConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PricingConfigToJson(this);
}

// ==========================
// LOCATION MODEL
// ==========================
@JsonSerializable()
class LatLng {
  final double latitude;
  final double longitude;

  LatLng({required this.latitude, required this.longitude});

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}
