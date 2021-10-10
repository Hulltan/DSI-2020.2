import 'package:english_words/english_words.dart';

class DSIWordPair extends Comparable<DSIWordPair> {
  int id;
  String first;
  String second;
  bool favorite;

  DSIWordPair() {
    WordPair wordPair = WordPair.random();
    this.first = _capitalize(wordPair.first);
    this.second = _capitalize(wordPair.second);
  }

  String _capitalize(String s) {
    return '${s[0].toUpperCase()}${s.substring(1)}';
  }

  @override
  String toString() {
    return '${this.first} ${this.second}';
  }

  @override
  int compareTo(DSIWordPair other) {
    throw UnimplementedError();
  }

}