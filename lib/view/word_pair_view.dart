import 'package:flutter/material.dart';
import 'package:contador/model/word_pair_model.dart';
import 'package:contador/controller/word_pair_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WordPairController _controller = WordPairController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, '/favorites',
                arguments: _controller.getFavorites()),
          ),
        ],
      ),
      body: ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final WordPairController _controller = WordPairController();
  final _biggerFont = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  Iterable<DSIWordPair> get items {
    List<DSIWordPair> result;
    result = _controller.getAll();
    return result;
  }

  _switchFavourite(DSIWordPair wordPair) {
    bool like = wordPair.favorite;
    if (like == false) {
      wordPair.favorite = true;
    } else {
      wordPair.favorite = false;
    }
    _controller.refresh();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2 * items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            child: _buildRow(context, items.elementAt(index)),
            onDismissed: (DismissDirection direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('The item has been removed.'),
                  duration: Duration(milliseconds: 400),
                ),
              );
              setState(() {
                _controller.delete(items.elementAt(index));
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

  Widget _buildRow(BuildContext context, DSIWordPair wordPair) {
    return ListTile(
      title: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$wordPair',
            style: _biggerFont,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/update', arguments: wordPair);
        },
      ),
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        child: Icon(
          wordPair.favorite ? Icons.favorite : Icons.favorite_border,
          color: wordPair.favorite ? Colors.greenAccent : Colors.white,
        ),
        onPressed: () => _switchFavourite(wordPair),
      ),
    );
  }
}

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final WordPairController _controller = WordPairController();

  @override
  Widget build(BuildContext context) {
    // DSIWordPair newWordPair = DSIWordPair();
    DSIWordPair pair = ModalRoute.of(context).settings.arguments;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('''Edit Startup's Name'''),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: pair.first,
                decoration: InputDecoration(
                  labelText: 'First',
                ),
                validator: (input) =>
                    input == '' ? 'You need at least 1 character' : null,
                onSaved: (value) => pair.first = value,
              ),
              TextFormField(
                initialValue: pair.second,
                decoration: InputDecoration(
                  labelText: 'Second',
                ),
                validator: (input) =>
                    input == '' ? 'You need at least 1 character' : null,
                onSaved: (value) => pair.second = value,
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    setState(() {
                      _controller.update(pair);
                      Navigator.of(context).pop();
                    });
                  }
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
      ),
    );
  }
}

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var _favoriteList = [];
  final _biggerFont = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    _favoriteList = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView.builder(
            itemCount: 2 * _favoriteList.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext _context, int i) {
              if (i.isOdd) {
                return Divider();
              }
              final int index = i ~/ 2;
              return _buildFavorite(context, _favoriteList[index]);
            }));
  }

  Widget _buildFavorite(BuildContext context, DSIWordPair favorite) {
    return ListTile(
      title: Text(
        favorite.toString(),
        style: _biggerFont,
      ),
    );
  }
}
