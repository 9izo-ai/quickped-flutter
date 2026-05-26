import 'package:json_annotation/json_annotation.dart';

part 'wallet_models.g.dart';

// ==========================
// TRANSACTION TYPE ENUM
// ==========================
enum TransactionType {
  @JsonValue('TOPUP')
  topup,
  @JsonValue('FARE_DEDUCTION')
  fareDeduction,
  @JsonValue('REFUND')
  refund,
  @JsonValue('PROMO_CREDIT')
  promoCredit,
}

// ==========================
// TRANSACTION STATUS ENUM
// ==========================
enum TransactionStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('SUCCESS')
  success,
  @JsonValue('FAILED')
  failed,
  @JsonValue('CANCELLED')
  cancelled,
}

// ==========================
// WALLET MODEL
// ==========================
@JsonSerializable()
class Wallet {
  final String id;
  final String userId;
  final String campusId;
  final double balance;
  final double totalTopups;
  final double totalDeductions;
  final DateTime lastUpdated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Wallet({
    required this.id,
    required this.userId,
    required this.campusId,
    required this.balance,
    required this.totalTopups,
    required this.totalDeductions,
    required this.lastUpdated,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}

// ==========================
// TRANSACTION MODEL
// ==========================
@JsonSerializable()
class Transaction {
  final String id;
  final String userId;
  final String walletId;
  final String campusId;
  final double amount;
  final TransactionType type;
  final TransactionStatus status;
  final double balanceBefore;
  final double balanceAfter;
  final String? rideId; // If fare deduction
  final String? topupMethod; // If topup: RAZORPAY, STRIPE, UPI, etc.
  final String? paymentReference; // Payment gateway transaction ID
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.walletId,
    required this.campusId,
    required this.amount,
    required this.type,
    required this.status,
    required this.balanceBefore,
    required this.balanceAfter,
    this.rideId,
    this.topupMethod,
    this.paymentReference,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

// ==========================
// TOPUP REQUEST/RESPONSE
// ==========================
@JsonSerializable()
class TopupRequest {
  final String userId;
  final String walletId;
  final double amount;
  final String paymentMethod; // RAZORPAY, STRIPE, UPI, etc.
  final String? phone; // For UPI topups
  final String? email; // For payment confirmation

  TopupRequest({
    required this.userId,
    required this.walletId,
    required this.amount,
    required this.paymentMethod,
    this.phone,
    this.email,
  });

  factory TopupRequest.fromJson(Map<String, dynamic> json) => _$TopupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TopupRequestToJson(this);
}

@JsonSerializable()
class TopupResponse {
  final String transactionId;
  final String paymentOrderId; // From payment gateway
  final double amount;
  final String status; // PENDING, SUCCESS, FAILED
  final String? paymentUrl; // URL to complete payment
  final String? errorMessage;
  final DateTime createdAt;

  TopupResponse({
    required this.transactionId,
    required this.paymentOrderId,
    required this.amount,
    required this.status,
    this.paymentUrl,
    this.errorMessage,
    required this.createdAt,
  });

  factory TopupResponse.fromJson(Map<String, dynamic> json) => _$TopupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TopupResponseToJson(this);
}

// ==========================
// TOPUP HISTORY MODEL
// ==========================
@JsonSerializable()
class TopupHistory {
  final List<Transaction> topups;
  final int totalCount;
  final double totalAmount;

  TopupHistory({
    required this.topups,
    required this.totalCount,
    required this.totalAmount,
  });

  factory TopupHistory.fromJson(Map<String, dynamic> json) => _$TopupHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$TopupHistoryToJson(this);
}
