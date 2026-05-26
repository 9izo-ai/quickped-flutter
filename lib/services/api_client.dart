import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';

// TODO: API CLIENT - Add request/response interceptors
// TODO: API CLIENT - Add token refresh logic
// TODO: API CLIENT - Add error handling and retry logic

class ApiClient {
  late Dio _dio;
  late String _authToken;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: Duration(seconds: AppConfig.apiTimeoutSeconds),
        receiveTimeout: Duration(seconds: AppConfig.apiTimeoutSeconds),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // TODO: API CLIENT - Add request interceptor for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_authToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // TODO: API CLIENT - Handle token refresh on 401
          // TODO: API CLIENT - Retry request after token refresh
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  // ==========================
  // AUTHENTICATION ENDPOINTS
  // ==========================

  // TODO: BACKEND API - POST /auth/otp/request
  // Send OTP to phone number
  Future<Response> requestOTP(String phoneNumber) async {
    try {
      return await _dio.post(
        '/auth/otp/request',
        data: {'phoneNumber': phoneNumber},
      );
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /auth/otp/verify
  // Verify OTP and get session token
  Future<Response> verifyOTP(String sessionId, String otp) async {
    try {
      return await _dio.post(
        '/auth/otp/verify',
        data: {'sessionId': sessionId, 'otp': otp},
      );
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /auth/signup
  // Complete user registration
  Future<Response> signup(Map<String, dynamic> userData) async {
    try {
      return await _dio.post('/auth/signup', data: userData);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /auth/login
  // Login user
  Future<Response> login(String phoneNumber) async {
    try {
      return await _dio.post(
        '/auth/login',
        data: {'phoneNumber': phoneNumber},
      );
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /auth/refresh
  // Refresh access token
  Future<Response> refreshToken(String refreshToken) async {
    try {
      return await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // CAMPUS ENDPOINTS
  // ==========================

  // TODO: BACKEND API - GET /campuses/{campusId}
  // Get campus configuration
  Future<Response> getCampus(String campusId) async {
    try {
      return await _dio.get('/campuses/$campusId');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - GET /campuses
  // List all available campuses
  Future<Response> listCampuses() async {
    try {
      return await _dio.get('/campuses');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - GET /campuses/{campusId}/docks
  // Get all docks in a campus
  Future<Response> getDocks(String campusId) async {
    try {
      return await _dio.get('/campuses/$campusId/docks');
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // BIKE ENDPOINTS
  // ==========================

  // TODO: BACKEND API - GET /bikes/{bikeId}
  // Get bike details and status
  Future<Response> getBike(String bikeId) async {
    try {
      return await _dio.get('/bikes/$bikeId');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /bikes/scan
  // Scan QR code and validate bike availability
  Future<Response> scanBike(String qrCode) async {
    try {
      return await _dio.post('/bikes/scan', data: {'qrCode': qrCode});
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // RIDE ENDPOINTS
  // ==========================

  // TODO: BACKEND API - POST /rides/start
  // Initiate a new ride
  Future<Response> startRide(Map<String, dynamic> rideData) async {
    try {
      return await _dio.post('/rides/start', data: rideData);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - GET /rides/active
  // Get current active ride
  Future<Response> getActiveRide() async {
    try {
      return await _dio.get('/rides/active');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /rides/{rideId}/end
  // End an active ride
  Future<Response> endRide(String rideId, Map<String, dynamic> endData) async {
    try {
      return await _dio.post('/rides/$rideId/end', data: endData);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /rides/{rideId}/lock
  // Temporarily lock bike during ride
  Future<Response> lockDuringRide(String rideId) async {
    try {
      return await _dio.post('/rides/$rideId/lock');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /rides/{rideId}/unlock
  // Temporarily unlock bike during ride
  Future<Response> unlockDuringRide(String rideId) async {
    try {
      return await _dio.post('/rides/$rideId/unlock');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - GET /rides/history
  // Get ride history
  Future<Response> getRideHistory({int page = 1, int limit = 20}) async {
    try {
      return await _dio.get('/rides/history', queryParameters: {'page': page, 'limit': limit});
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - GET /rides/{rideId}/receipt
  // Get ride receipt
  Future<Response> getRideReceipt(String rideId) async {
    try {
      return await _dio.get('/rides/$rideId/receipt');
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // WALLET ENDPOINTS
  // ==========================

  // TODO: BACKEND API - GET /wallet
  // Get current wallet balance
  Future<Response> getWallet() async {
    try {
      return await _dio.get('/wallet');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /wallet/topup
  // Initiate wallet top-up
  Future<Response> initiateTopup(Map<String, dynamic> topupData) async {
    try {
      return await _dio.post('/wallet/topup', data: topupData);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - POST /wallet/topup/verify
  // Verify payment and complete topup
  Future<Response> verifyTopup(String paymentOrderId) async {
    try {
      return await _dio.post('/wallet/topup/verify', data: {'paymentOrderId': paymentOrderId});
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - GET /wallet/transactions
  // Get transaction history
  Future<Response> getTransactions({int page = 1, int limit = 20}) async {
    try {
      return await _dio.get('/wallet/transactions', queryParameters: {'page': page, 'limit': limit});
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // USER ENDPOINTS
  // ==========================

  // TODO: BACKEND API - GET /user
  // Get current user profile
  Future<Response> getUserProfile() async {
    try {
      return await _dio.get('/user');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: BACKEND API - PUT /user
  // Update user profile
  Future<Response> updateUserProfile(Map<String, dynamic> userData) async {
    try {
      return await _dio.put('/user', data: userData);
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // TODO: Add more endpoints as needed
  // - Admin endpoints
  // - Fleet management
  // - Notifications
  // - Analytics
  // ==========================
}

// Riverpod provider for API client
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
