
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:developer';

FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;
class RemoteConfigsService {
  RemoteConfigsService._();

  /// [RemoteConfigsService] factory constructor.
  static Future<RemoteConfigsService> create() async {
    final RemoteConfigsService remoteConfigsService = RemoteConfigsService._();
    await remoteConfigsService._init();
    return remoteConfigsService;
  }

  _init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig
        .setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(microseconds: 1),
      minimumFetchInterval: const Duration(milliseconds: 100),
    ))
        .then((value) async {
      await remoteConfig.fetchAndActivate();
      log('Initialized');
    });
    firebaseRemoteConfig = FirebaseRemoteConfig.instance;
  }

  bool getBoolean(String key){
    return firebaseRemoteConfig.getBool(key);
  }
  String getString(String key){
    return firebaseRemoteConfig.getString(key);
  }
  int getInteger(String key){
    return firebaseRemoteConfig.getInt(key);
  }
  double getDouble(String key){
    return firebaseRemoteConfig.getDouble(key);
  }
  RemoteConfigValue getValues(String key){
    return firebaseRemoteConfig.getValue(key);
  }
}
