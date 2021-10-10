import 'package:contador/model/word_pair_model.dart';

int _nextWordPairId = 1;
List<DSIWordPair> _wordPairs;

class WordPairController {
  WordPairController() {
    _initWordPairs();
  }

  void _initWordPairs() {
    if (_wordPairs != null) return;

    _wordPairs = <DSIWordPair>[];
    for (var i = 0; i < 20; i++) {
      DSIWordPair wordPair = DSIWordPair();
      wordPair.id = _nextWordPairId++;
      _wordPairs.add(wordPair);
    }
    refresh();
  }

  List<DSIWordPair> getAll() {
    return List.unmodifiable(_wordPairs);
  }

  DSIWordPair getById(int id) {
    if (id == null) return null;

    for (var wp in _wordPairs) {
      if (wp.id == id) return wp;
    }
    return null;
  }

  List<DSIWordPair> getFavorites() {
    List<DSIWordPair> result = _wordPairs;
    result = _wordPairs.where((i) => i.favorite).toList();
    return List.unmodifiable(result);
  }

  void refresh(){
    _wordPairs.sort((a,b) => a.first.compareTo(b.first));
  }

  void update(DSIWordPair wordPair) {
    DSIWordPair oldWordPair = getById(wordPair.id);
    delete(oldWordPair);
    _wordPairs.add(wordPair);
    refresh();
  }

  void delete(DSIWordPair wordPair) {
    _wordPairs.remove(wordPair);
  }
}
