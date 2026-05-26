import 'package:json_annotation/json_annotation.dart';

part 'user_models.g.dart';

// ==========================
// USER ROLE ENUM
// ==========================
enum UserRole {
  @JsonValue('VERIFIED_RIDER')
  verifiedRider,
  @JsonValue('GUEST_RIDER')
  guestRider,
  @JsonValue('OPERATOR')
  operator,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('QUICKPED_ADMIN')
  quickpedAdmin,
}

// ==========================
// USER MODEL
// ==========================
@JsonSerializable()
class User {
  final String id;
  final String phoneNumber;
  final String? email;
  final String? institutionalId;
  final String displayName;
  final UserRole role;
  final String campusId;
  final double walletBalance;
  final bool isActive;
  final bool isBlocked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? profilePhotoUrl;
  final String? fcmToken; // For push notifications

  User({
    required this.id,
    required this.phoneNumber,
    this.email,
    this.institutionalId,
    required this.displayName,
    required this.role,
    required this.campusId,
    required this.walletBalance,
    required this.isActive,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    this.profilePhotoUrl,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  bool get isVerifiedRider => role == UserRole.verifiedRider;
  bool get isGuestRider => role == UserRole.guestRider;
  bool get isOperator => role == UserRole.operator;
  bool get isAdmin => role == UserRole.admin;
  bool get isQuickpedAdmin => role == UserRole.quickpedAdmin;
}

// ==========================
// AUTHENTICATION MODELS
// ==========================
@JsonSerializable()
class OTPRequest {
  final String phoneNumber;

  OTPRequest({required this.phoneNumber});

  factory OTPRequest.fromJson(Map<String, dynamic> json) => _$OTPRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OTPRequestToJson(this);
}

@JsonSerializable()
class OTPResponse {
  final String sessionId;
  final int expiresIn; // seconds
  final String message;

  OTPResponse({
    required this.sessionId,
    required this.expiresIn,
    required this.message,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) => _$OTPResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OTPResponseToJson(this);
}

@JsonSerializable()
class OTPVerifyRequest {
  final String sessionId;
  final String otp;

  OTPVerifyRequest({
    required this.sessionId,
    required this.otp,
  });

  factory OTPVerifyRequest.fromJson(Map<String, dynamic> json) => _$OTPVerifyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OTPVerifyRequestToJson(this);
}

@JsonSerializable()
class SignUpRequest {
  final String phoneNumber;
  final String? institutionalId;
  final String? institutionalEmail;
  final String displayName;
  final String campusId;

  SignUpRequest({
    required this.phoneNumber,
    this.institutionalId,
    this.institutionalEmail,
    required this.displayName,
    required this.campusId,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final User user;
  final String accessToken;
  final String refreshToken;
  final int expiresIn; // seconds

  AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

// ==========================
// LOCAL AUTH STATE
// ==========================
class LocalAuthState {
  final User? user;
  final String? accessToken;
  final String? refreshToken;
  final DateTime? tokenExpiresAt;
  final bool isAuthenticated;

  LocalAuthState({
    this.user,
    this.accessToken,
    this.refreshToken,
    this.tokenExpiresAt,
    this.isAuthenticated = false,
  });

  bool get isTokenExpired {
    if (tokenExpiresAt == null) return true;
    return DateTime.now().isAfter(tokenExpiresAt!);
  }
}
