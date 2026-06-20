import 'package:dimos_cats/models/cat.dart';

abstract class CatsRepository {
  Future<List<Cat>> getCats();
}
