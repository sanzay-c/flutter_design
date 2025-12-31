  import 'package:flutter_dotenv/flutter_dotenv.dart';

  enum Environment { dev, staging, prod }

  class EnvConfig {
    static Environment _environment = Environment.dev;
    
    static Environment get environment => _environment; // यो getter ले बाहिरबाट अहिले कुन environment छ भनेर थाहा पाउन दिन्छ। -> output: print(EnvConfig.environment);  // dev, staging, prod
    
    static Future<void> initialize(Environment env) async { // यो function ले: Environment सेट गर्छ (dev, staging, prod) कुन .env फाइल लोड गर्ने निर्णय गर्छ
      _environment = env;
      
      String envFile;
      switch (env) {  // this switch does is if env == dev then it will open '.env.dev'
        case Environment.dev:
          envFile = '.env.dev'; 
          break;
        case Environment.staging:
          envFile = '.env.staging';
          break;
        case Environment.prod:
          envFile = '.env.prod';
          break;
      }
      
      await dotenv.load(fileName: envFile); // it loads the value inside the file
    }
    
    // Getter methods
    static String get appName => dotenv.get('APP_NAME', fallback: 'MyApp'); //.env फाइलबाट, APP_NAME को value निकाल्छ।, यदि फेला परेन भने → "MyApp" दिन्छ। // dotEnv ko name access garna ko lagi 
    static String get apiBaseUrl => dotenv.get('API_BASE_URL');
    static String get apiKey => dotenv.get('API_KEY');
    static bool get debugMode => 
        dotenv.get('DEBUG_MODE', fallback: 'false') == 'true';
    
    // Custom getter with default value
    static String getString(String key, {String defaultValue = ''}) {
      return dotenv.get(key, fallback: defaultValue);
    }
  }