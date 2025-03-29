class AppConstants {
  // App Info
  static const appName = 'Pendo';
  static const appVersion = '1.0.0';
  
  // API Endpoints
  static const apiVersion = 'v1';
  static const timeout = Duration(seconds: 30);
  
  // Cache Keys
  static const tokenKey = 'auth_token';
  static const userKey = 'user_data';
  static const settingsKey = 'app_settings';
  
  // Validation
  static const minPasswordLength = 8;
  static const maxBioLength = 500;
  static const maxPhotos = 6;
  
  // Pagination
  static const defaultPageSize = 20;
  static const maxPageSize = 50;
  
  // Location
  static const defaultSearchRadius = 10.0; // km
  static const maxSearchRadius = 100.0; // km
  
  // Tribes
  static const maxTribeMembers = 100;
  static const tribeCreationCooldown = Duration(days: 30);
  
  // Premium Features
  static const freeSwipesPerDay = 100;
  static const premiumSwipesPerDay = 1000;
  
  // Chat
  static const maxMessageLength = 1000;
  static const messagePageSize = 50;
  
  // Supported Languages
  static const supportedLocales = [
    'en', // English
    'sw', // Swahili
    'zu', // Zulu
  ];
  
  // File Upload
  static const maxFileSize = 10 * 1024 * 1024; // 10MB
  static const allowedImageTypes = [
    'image/jpeg',
    'image/png',
  ];
  
  // Error Messages
  static const networkError = 'Please check your internet connection';
  static const serverError = 'Something went wrong, please try again later';
  static const timeoutError = 'Request timeout, please try again';
  static const invalidCredentials = 'Invalid email or password';
  static const unauthorized = 'Please login to continue';
  
  // Success Messages
  static const profileUpdated = 'Profile updated successfully';
  static const photoUploaded = 'Photo uploaded successfully';
  static const matchCreated = 'It\'s a match!';
  static const messageDeleted = 'Message deleted';
  
  // Premium Features
  static const premiumFeatures = [
    'Unlimited Swipes',
    'See Who Likes You',
    'Advanced Filters',
    'Boost Your Profile',
    'Super Likes',
    'Rewind Last Swipe',
  ];
  
  // Report Reasons
  static const reportReasons = [
    'Inappropriate Content',
    'Fake Profile',
    'Harassment',
    'Spam',
    'Other',
  ];
  
  // Animations
  static const animationDuration = Duration(milliseconds: 300);
  static const splashDuration = Duration(seconds: 2);
}
