// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';
//
// class EditScreen extends StatefulWidget {
//   @override
//   _EditScreenState createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   String _first;
//   String _second;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('''Edit Startup's Name'''),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(15),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'First',
//               ),
//               onSaved: (value) =>  _first = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Second',
//               ),
//               onSaved: (value) =>  _second = value,
//             ),
//             TextButton(
//               onPressed: () {
//                  = WordPair(_first, _second);
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Save',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
