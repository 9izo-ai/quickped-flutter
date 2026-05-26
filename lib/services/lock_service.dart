import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/bike_models.dart';

// ==========================
// IOT LOCK SERVICE ABSTRACTION
// ==========================
// This service abstracts the IoT lock integration
// allowing different lock vendors to be swapped without changing app logic

// TODO: IOT LOCK - Implement lock vendor-specific logic
// Currently using generic REST API model
// Extend this for specific vendors: Mobike, Ofo, etc.

class LockService {
  late Dio _dio;

  LockService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.iotLockServiceUrl,
        connectTimeout: Duration(seconds: AppConfig.lockCommandTimeoutSeconds),
        receiveTimeout: Duration(seconds: AppConfig.lockCommandTimeoutSeconds),
      ),
    );
  }

  // ==========================
  // LOCK COMMANDS
  // ==========================

  /// Unlock bike - hardware confirmation required
  /// TODO: IOT LOCK - Implement unlock command for specific vendor
  Future<LockCommandResponse> unlock(String lockHardwareId) async {
    try {
      final response = await _dio.post(
        '/commands/unlock',
        data: {
          'lockHardwareId': lockHardwareId,
          'vendor': AppConfig.lockVendor,
          'requestedAt': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LockCommandResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to unlock: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Unlock failed: $e');
    }
  }

  /// Lock bike - used on ride end
  /// TODO: IOT LOCK - Implement lock command for specific vendor
  Future<LockCommandResponse> lock(String lockHardwareId) async {
    try {
      final response = await _dio.post(
        '/commands/lock',
        data: {
          'lockHardwareId': lockHardwareId,
          'vendor': AppConfig.lockVendor,
          'requestedAt': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LockCommandResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to lock: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Lock failed: $e');
    }
  }

  /// Temporary lock - bike stays in ride, lock is just temporarily secured
  /// TODO: IOT LOCK - Implement temporary lock for specific vendor
  Future<LockCommandResponse> temporaryLock(String lockHardwareId) async {
    try {
      final response = await _dio.post(
        '/commands/temp-lock',
        data: {
          'lockHardwareId': lockHardwareId,
          'vendor': AppConfig.lockVendor,
          'requestedAt': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LockCommandResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to temp lock: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Temporary lock failed: $e');
    }
  }

  /// Temporary unlock - from temporary locked state without QR scan
  /// TODO: IOT LOCK - Implement temporary unlock for specific vendor
  Future<LockCommandResponse> temporaryUnlock(String lockHardwareId) async {
    try {
      final response = await _dio.post(
        '/commands/temp-unlock',
        data: {
          'lockHardwareId': lockHardwareId,
          'vendor': AppConfig.lockVendor,
          'requestedAt': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LockCommandResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to temp unlock: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Temporary unlock failed: $e');
    }
  }

  /// Get lock status and battery level
  /// TODO: IOT LOCK - Implement status check for specific vendor
  Future<LockStatusData> getStatus(String lockHardwareId) async {
    try {
      final response = await _dio.get('/status/$lockHardwareId');

      if (response.statusCode == 200) {
        return LockStatusData.fromJson(response.data);
      } else {
        throw Exception('Failed to get status: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Status check failed: $e');
    }
  }

  /// Get GPS coordinates from lock
  /// TODO: IOT LOCK - Implement GPS query for specific vendor
  /// IMPORTANT: Uses lock GPS, not phone GPS, to prevent spoofing
  Future<({double latitude, double longitude})> getLocation(String lockHardwareId) async {
    try {
      final response = await _dio.get('/location/$lockHardwareId');

      if (response.statusCode == 200) {
        return (
          latitude: response.data['latitude'],
          longitude: response.data['longitude'],
        );
      } else {
        throw Exception('Failed to get location: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Location fetch failed: $e');
    }
  }

  /// Validate if bike is within dock geofence radius
  /// TODO: IOT LOCK - Add geofencing validation logic
  bool isWithinGeofence(
    double bikeLat,
    double bikeLng,
    double dockLat,
    double dockLng,
    double radiusMeters,
  ) {
    // Haversine formula to calculate distance
    const earthRadiusMeters = 6371000.0;
    final dLat = _degreesToRadians(dockLat - bikeLat);
    final dLng = _degreesToRadians(dockLng - bikeLng);

    final a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(_degreesToRadians(bikeLat)) *
            Math.cos(_degreesToRadians(dockLat)) *
            Math.sin(dLng / 2) *
            Math.sin(dLng / 2);

    final c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    final distance = earthRadiusMeters * c;

    return distance <= radiusMeters;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }
}

// TODO: IOT LOCK - Create vendor-specific implementations
// class MobikeLocksService extends LockService { }
// class OfoLocksService extends LockService { }
