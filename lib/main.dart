import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:contador/routes.dart';
import 'package:contador/edit_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.HOME: (_) => RandomWords(),
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  void _delete(WordPair pair) {
    _saved.remove(pair);
  }

  void _update(int i){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          String _first;
          String _second;

          return Scaffold(
            appBar: AppBar(
              title: Text('''Edit Startup's Name'''),
            ),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First',
                    ),
                    onSaved: (value) =>  _first = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Second',
                    ),
                    onSaved: (value) =>  _second = value,
                  ),
                  TextButton(
                    onPressed: () {
                      _suggestions[i] = WordPair(_first, _second);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey(_suggestions[index]),
            child: _buildRow(_suggestions[index]),
            onDismissed: (DismissDirection direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('The item has been removed.'),
                  duration: Duration(milliseconds: 400),
                ),
              );
              setState(() {
                _delete(_suggestions[index]);
                _suggestions.removeAt(index);
              });
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete_forever),
            ),
          );
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        ),
        onPressed: () {
          setState(() => _update(_suggestions.indexOf(pair)));

        },
      ),
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        child: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.greenAccent : Colors.white,
        ),
        onPressed: () {
          setState(() {
            if (alreadySaved) {
              _delete(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
    );
  }
}
