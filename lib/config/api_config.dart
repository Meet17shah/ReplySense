/// API Configuration
/// 
/// SECURITY NOTE: This API key is visible in the app code.
/// For production, consider using Firebase Remote Config or environment variables.
class ApiConfig {
  /// Google Gemini API Key
  /// Get your free key at: https://makersuite.google.com/app/apikey
  static const String geminiApiKey = "AIzaSyASbIirert6UlfJRApc1neNQoiPGlIrEIo";
  
  /// Daily request limit per user
  static const int dailyRequestLimit = 20;
  
  /// AI Model to use
  static const String geminiModel = "gemini-pro";
  
  /// Temperature for AI responses (0.0 - 1.0)
  /// Lower = more deterministic, Higher = more creative
  static const double aiTemperature = 0.7;
  
  /// Maximum tokens in AI response
  static const int maxOutputTokens = 2048;
}
