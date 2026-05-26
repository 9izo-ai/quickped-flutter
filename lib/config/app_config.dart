// TODO: CONFIGURATION - Update all values with actual configuration

class AppConfig {
  // ==========================
  // BACKEND API CONFIGURATION
  // ==========================
  // TODO: BACKEND API - Set actual backend base URL
  // Example: 'https://api.quickped.com/v1'
  static const String apiBaseUrl = 'http://localhost:8000/api/v1';
  
  // API timeout in seconds
  static const int apiTimeoutSeconds = 30;

  // ==========================
  // FIREBASE CONFIGURATION
  // ==========================
  // TODO: FIREBASE - Add your Firebase project credentials
  static const String firebaseProjectId = 'quickped-project-id';
  static const String firebaseAppId = 'quickped-app-id';
  static const String firebaseMeasurementId = 'quickped-measurement-id';
  
  // Firebase Realtime Database URL
  // TODO: FIREBASE - Set actual Firebase DB URL
  static const String firebaseDbUrl = 'https://quickped-project-id.firebaseio.com';

  // ==========================
  // GOOGLE MAPS CONFIGURATION
  // ==========================
  // TODO: GOOGLE MAPS - Add your Google Maps API key
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  // ==========================
  // PAYMENT GATEWAY CONFIGURATION
  // ==========================
  // TODO: PAYMENT GATEWAY - Choose and configure payment provider
  // Options: Razorpay, Stripe, PayPal, local provider
  
  // For Razorpay
  // static const String razorpayKeyId = 'YOUR_RAZORPAY_KEY_ID';
  // static const String razorpayKeySecret = 'YOUR_RAZORPAY_SECRET';
  
  // For Stripe
  // static const String stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
  // static const String stripeSecretKey = 'YOUR_STRIPE_SECRET_KEY';
  
  static const String paymentGateway = 'RAZORPAY'; // or 'STRIPE', 'PAYPAL'

  // ==========================
  // IOT LOCK SERVICE CONFIGURATION
  // ==========================
  // TODO: IOT LOCK - Configure lock vendor API
  // This should be abstracted and support multiple vendors
  // Example vendors: Mobike, Ofo, custom solution
  
  static const String iotLockServiceUrl = 'http://localhost:3000/lock-service';
  
  // Lock command timeout in seconds
  static const int lockCommandTimeoutSeconds = 3;
  
  // Lock vendor type
  // TODO: IOT LOCK - Set actual lock vendor
  static const String lockVendor = 'GENERIC'; // e.g., 'MOBIKE', 'OFO', 'GENERIC'

  // ==========================
  // REAL-TIME CONFIGURATION
  // ==========================
  // WebSocket/Real-time update configuration
  // TODO: REAL-TIME - Configure WebSocket or polling settings
  static const String realtimeServiceUrl = 'ws://localhost:8000/ws';
  static const int realtimeHeartbeatSeconds = 30;

  // ==========================
  // APP CONFIGURATION
  // ==========================
  static const String appName = 'QuickPed';
  static const String appVersion = '1.0.0';
  
  // Minimum wallet balance required to start a ride
  // TODO: APP CONFIG - This will be overridden by campus-specific config
  static const double minimumWalletBalance = 50.0;
  
  // Geofence radius for dock validation (in meters)
  // TODO: APP CONFIG - This will be overridden by dock-specific config
  static const double defaultGeofenceRadius = 50.0;

  // ==========================
  // FEATURE FLAGS
  // ==========================
  static const bool enableOfflineMode = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePreBooking = false; // Phase 2 feature
  static const bool enableGeofencing = false; // Phase 2 feature
  static const bool enableManualOverride = true; // For operators

  // ==========================
  // NOTIFICATIONS CONFIGURATION
  // ==========================
  // TODO: NOTIFICATIONS - Configure Firebase Cloud Messaging
  static const bool enablePushNotifications = true;
  
  // Low balance alert threshold
  static const double lowBalanceAlertThreshold = 50.0;
  
  // Session timeout in minutes
  static const int sessionTimeoutMinutes = 30;
}
