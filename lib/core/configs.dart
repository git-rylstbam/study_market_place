/// CreateDate: 2025/7/4 17:27
/// Author: Lee
/// Description:

abstract class EnvConfig {
  static const buildStamp = String.fromEnvironment(
    'PACKAGE_DATE',
    defaultValue: '0',
  );

  static const env = String.fromEnvironment('APP_ENV', defaultValue: test);
  static const target = String.fromEnvironment('TARGET_ENV');

  static const isProd = env == EnvConfig.prod;
  static const isTest = env == EnvConfig.test;

  static const test = 'test';
  static const prod = 'prod';

  static const String appName = 'Study Market Place';
}
