class DataManager {
  DataManager._();
  static final _instance = DataManager._();
  static DataManager get instance => _instance;

  String? userEmail;
  DateTime? creationDate;
  DateTime? lastSignTime;
  
}