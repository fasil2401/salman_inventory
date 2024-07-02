import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;
  static const _keyVersion = 'version';
  static const _keyTheme = 'theme';
  static const _keyDeviceInfo = 'deviceInfo';
  static const _keyServerIp = 'server_ip';
  static const _keyServerPort = 'port';
  static const _keyServerDatabase = 'database';
  static const _keyUserName = 'username';
  static const _keyPreviousUserName = 'previousUsername';
  static const _keyUserPassword = 'password';
  static const _keyIslogedIn = 'islogedin';
  static const _keyConnection = 'isConnected';
  static const _keyLocation = 'location';
  static const _keyLocationId = 'locationId';
  static const _keyProductSync = 'productSync';
  static const _keyTransferTypeSync = 'transferTypeSync';
  static const _keyUserSecuritySync = 'userSecuritySync ';
  static const _keySysDocSync = 'sysDocSync';
  static const _keyLocationSync = 'locationSync';
  static const _keyProductSyncDate = 'productSyncDate';
  static const _keyProductSyncDateView = 'productSyncDateView';
  static const _keyProductSyncTransferType = 'productSyncTransferType';
  static const _keyConnectionName = 'connectionName';
  static const _keyRememberPassword = 'rememberPassword';
  static const _keyIsUpdatingExistingApp = 'isUpdatingExistingApp';
  static const _keyDisableCamera = 'disableCamera';
  static const _keyIsSyncCompleted = 'isSyncCompleted';
  static const _keyDisableDirectAddItem = 'disableDirectAddItem';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTheme(String theme) async =>
      await _preferences!.setString(_keyTheme, theme);

  static String? getTheme() => _preferences!.getString(_keyTheme);

  static Future setDeviceInfo(String info) async =>
      await _preferences!.setString(_keyDeviceInfo, info);

  static String? getDeviceInfo() => _preferences!.getString(_keyDeviceInfo);

  static Future setProductSync(String sync) async =>
      await _preferences!.setString(_keyProductSync, sync);

  static String? getProductSync() => _preferences!.getString(_keyProductSync);

  static String? getUserPassword() => _preferences!.getString(_keyUserPassword);

  static Future setTransferTypeSync(String sync) async =>
      await _preferences!.setString(_keyTransferTypeSync, sync);

  static String? getTransferTypeSync() =>
      _preferences!.getString(_keyTransferTypeSync);

  static Future setUserSecuritySync(String sync) async =>
      await _preferences!.setString(_keyUserSecuritySync, sync);

  static String? getUserSecuritySync() =>
      _preferences!.getString(_keyUserSecuritySync);

  static Future setSysDocSync(String sync) async =>
      await _preferences!.setString(_keySysDocSync, sync);

  static String? getSysDocSync() => _preferences!.getString(_keySysDocSync);

  static Future setLocationSync(String sync) async =>
      await _preferences!.setString(_keyLocationSync, sync);

  static String? getLocationSync() => _preferences!.getString(_keyLocationSync);

  static Future setVersion(String version) async =>
      await _preferences!.setString(_keyVersion, version);

  static String? getVersion() => _preferences!.getString(_keyVersion);

  static Future setUsername(String userName) async =>
      await _preferences!.setString(_keyUserName, userName);

  static String? getUsername() => _preferences!.getString(_keyUserName);

  static Future setConnectionName(String connectionName) async =>
      await _preferences!.setString(_keyConnectionName, connectionName);

  static String? getConnectionName() =>
      _preferences!.getString(_keyConnectionName);

  static Future setPreviousUsername(String userName) async =>
      await _preferences!.setString(_keyPreviousUserName, userName);

  static String? getPreviousUsername() =>
      _preferences!.getString(_keyPreviousUserName);

  static Future setUserPassword(String password) async =>
      await _preferences!.setString(_keyUserPassword, password);

  // static bool? getUserPassword() => _preferences!.getBool(_keyUserPassword);

  static Future setServerIp(String serverIp) async =>
      await _preferences!.setString(_keyServerIp, serverIp);

  static String? getServerIp() => _preferences!.getString(_keyServerIp);

  static Future setPort(String port) async =>
      await _preferences!.setString(_keyServerPort, port);

  static String? getPort() => _preferences!.getString(_keyServerPort);

  static Future setDatabase(String database) async =>
      await _preferences!.setString(_keyServerDatabase, database);

  static String? getDatabase() => _preferences!.getString(_keyServerDatabase);

  static Future setLogin(String isLogin) async =>
      await _preferences!.setString(_keyIslogedIn, isLogin);

  static String? getLogin() => _preferences!.getString(_keyIslogedIn);

  static Future setConnection(String isConnected) async =>
      await _preferences!.setString(_keyConnection, isConnected);

  static String? getConnection() => _preferences!.getString(_keyConnection);

  static Future setLocation(String location) async =>
      await _preferences!.setString(_keyLocation, location);

  static String? getLocation() => _preferences!.getString(_keyLocation);

  static Future setLocationId(String locationId) async =>
      await _preferences!.setString(_keyLocationId, locationId);

  static String? getLocationId() => _preferences!.getString(_keyLocationId);

  static Future setTransferDate(String date) async =>
      await _preferences!.setString(_keyProductSyncDate, date);

  static String? getTransferDate() =>
      _preferences!.getString(_keyProductSyncDate);

  static Future setTransferDateView(String date) async =>
      await _preferences!.setString(_keyProductSyncDateView, date);

  static String? getTransferDateView() =>
      _preferences!.getString(_keyProductSyncDateView);

  static Future setSyncTransferType(String transferType) async =>
      await _preferences!.setString(_keyProductSyncTransferType, transferType);

  static String? getSyncTransferType() =>
      _preferences!.getString(_keyProductSyncTransferType);
  static Future setRememberPassword(bool isRemember) async =>
      await _preferences!.setBool(_keyRememberPassword, isRemember);

  static bool? getRememberPassword() =>
      _preferences!.getBool(_keyRememberPassword);

  static Future setIsUpdatingExistingApp(bool isUpdating) async =>
      await _preferences!.setBool(_keyIsUpdatingExistingApp, isUpdating);

  static bool? getIsUpdatingExistingApp() =>
      _preferences!.getBool(_keyIsUpdatingExistingApp);

  static Future setIsCameraDisabled(int isDisable) async =>
      await _preferences!.setInt(_keyDisableCamera, isDisable);

  static int? getIsCameraDisabled() => _preferences!.getInt(_keyDisableCamera);

  static Future setIsSyncCompleted(bool isSynced) async =>
      await _preferences!.setBool(_keyIsSyncCompleted, isSynced);

  static bool? getIsSyncCompleted() =>
      _preferences!.getBool(_keyIsSyncCompleted);
  static Future setIsDirectAddItemDisabled(int isDisable) async =>
      await _preferences!.setInt(_keyDisableDirectAddItem, isDisable);

  static int? getIsDirectAddItemDisabled() =>
      _preferences!.getInt(_keyDisableDirectAddItem);
}
