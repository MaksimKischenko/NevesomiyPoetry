import 'package:nevesomiy/data/data.dart';

class PoemsRepository {
  PoemsRepository._();
  static final _instance = PoemsRepository._();
  static PoemsRepository get instance => _instance;
  
  var _poems = <Poem>[];
  List<Poem> get poems => _poems;

  // ignore: use_setters_to_change_properties
  void addAll(List<Poem> poems) {
    _poems = poems;
  }

  void clear() {
    _poems.clear();
  }
}