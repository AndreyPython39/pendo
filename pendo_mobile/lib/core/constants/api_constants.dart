class ApiConstants {
  // Base URLs
  static const baseUrl = 'https://api.pendo.africa';
  static const apiPrefix = '/api/v1';
  
  // Authentication
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const verifyEmail = '/auth/verify-email';
  static const verifyPhone = '/auth/verify-phone';
  static const refreshToken = '/auth/refresh-token';
  static const forgotPassword = '/auth/forgot-password';
  static const resetPassword = '/auth/reset-password';
  static const logout = '/auth/logout';
  
  // User Profile
  static const profile = '/profile';
  static const updateProfile = '/profile/update';
  static const uploadPhoto = '/profile/photos';
  static const deletePhoto = '/profile/photos/{id}';
  static const updateLocation = '/profile/location';
  static const updatePreferences = '/profile/preferences';
  
  // Matching
  static const getProfiles = '/matching/profiles';
  static const like = '/matching/like/{id}';
  static const pass = '/matching/pass/{id}';
  static const superLike = '/matching/super-like/{id}';
  static const matches = '/matching/matches';
  static const unmatch = '/matching/unmatch/{id}';
  
  // Chat
  static const conversations = '/chat/conversations';
  static const messages = '/chat/messages/{conversationId}';
  static const sendMessage = '/chat/messages/{conversationId}/send';
  static const deleteMessage = '/chat/messages/{messageId}';
  static const markRead = '/chat/conversations/{conversationId}/read';
  
  // Tribes
  static const tribes = '/tribes';
  static const createTribe = '/tribes/create';
  static const joinTribe = '/tribes/{id}/join';
  static const leaveTribe = '/tribes/{id}/leave';
  static const tribeMembers = '/tribes/{id}/members';
  static const tribeChat = '/tribes/{id}/chat';
  static const tribeVote = '/tribes/{id}/vote';
  
  // Moderation
  static const report = '/moderation/report';
  static const block = '/moderation/block/{id}';
  static const unblock = '/moderation/unblock/{id}';
  
  // Premium
  static const subscriptions = '/premium/subscriptions';
  static const purchase = '/premium/purchase';
  static const restore = '/premium/restore';
  
  // Settings
  static const settings = '/settings';
  static const notifications = '/settings/notifications';
  static const privacy = '/settings/privacy';
  static const deleteAccount = '/settings/delete-account';
  
  // Miscellaneous
  static const icebreakers = '/icebreakers';
  static const feedback = '/feedback';
  static const support = '/support';
  
  // Gifts
  static const gifts = '/gifts';
  static const receivedGifts = '/gifts/received';
  static const sentGifts = '/gifts/sent';
  static String sendGift(int giftId, int receiverId) => '/gifts/$giftId/send/$receiverId';
  
  // Premium
  static const premium = '/premium';
  static const premiumSubscribe = '/premium/subscribe';
  static const premiumUnsubscribe = '/premium/unsubscribe';
  static const premiumFeatures = '/premium/features';
  static const premiumStatus = '/premium/status';
  
  // Events
  static const events = '/events';
  static String eventDetails(int id) => '/events/$id';
  static String joinEvent(int id) => '/events/$id/join';
  static String leaveEvent(int id) => '/events/$id/leave';
  
  // Headers
  static const authHeader = 'Authorization';
  static const bearerPrefix = 'Bearer ';
  static const contentType = 'Content-Type';
  static const applicationJson = 'application/json';
  static const accept = 'Accept';
  static const acceptLanguage = 'Accept-Language';
  
  // Error Codes
  static const unauthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const serverError = 500;
  
  // Timeouts
  static const connectionTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);
  
  // Cache Control
  static const cacheControl = 'Cache-Control';
  static const noCache = 'no-cache';
  static const maxAge = 'max-age=';
}
