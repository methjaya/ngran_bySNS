// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class SelectGroups extends StatefulWidget {
//   const SelectGroups({super.key});

//   @override
//   State<SelectGroups> createState() => _SelectGroupsState();
// }

// class _SelectGroupsState extends State<SelectGroups> {
//   static Set<String> _selectedOptions = {};
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Select options'),
//               content: MultiSelectCheckboxListTile(),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('CANCEL'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     // Do something with the selected options
//                     // Navigator.of(context).pop();
//                     print(_selectedOptions);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: const Text('Select options'),
//     );
//   }
// }

// class MultiSelectCheckboxListTile extends StatefulWidget {
//   @override
//   _MultiSelectCheckboxListTileState createState() =>
//       _MultiSelectCheckboxListTileState();
// }

// class _MultiSelectCheckboxListTileState
//     extends State<MultiSelectCheckboxListTile> {
//   static Set<String> _selectedOptions = {};

//   final List<String> _options = [
//     'Option 1',
//     'Option 2',
//     'Option 3',
//     'Option 4',
//     'Option 5',
//   ];

//   void _onOptionSelected(String option) {
//     setState(() {
//       if (_MyButtonState._selectedOptions.contains(option)) {
//         _MyButtonState._selectedOptions.remove(option);
//       } else {
//         _MyButtonState._selectedOptions.add(option);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 320,
//       width: 300,
//       child: ListView.builder(
//         itemCount: _options.length,
//         itemBuilder: (BuildContext context, int index) {
//           final option = _options[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: SizedBox(
//               height: 55,
//               width: 200,
//               child: CheckboxListTile(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 title: Text(option),
//                 tileColor: Colors.grey[350],
//                 value: _MyButtonState._selectedOptions.contains(option),
//                 onChanged: (value) {
//                   _onOptionSelected(option);
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class MyButton extends StatefulWidget {
//   _MultiSelectCheckboxListTileState at = _MultiSelectCheckboxListTileState();
//   @override
//   State<MyButton> createState() => _MyButtonState();
// }

// class _MyButtonState extends State<MyButton> {
//   static Set<String> _selectedOptions = {};
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Select options'),
//               content: MultiSelectCheckboxListTile(),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('CANCEL'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     // Do something with the selected options
//                     // Navigator.of(context).pop();
//                     print(_MultiSelectCheckboxListTileState._selectedOptions);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Text('Select options'),
//     );
//   }
// }






// import 'package:flutter/material.dart';

// class MyAlertDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         showModalBottomSheet<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return Container(
//               padding: EdgeInsets.all(50),
//               height: 300,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 itemBuilder: (BuildContext context, int index) {
//                   final option = "Text";
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: SizedBox(
//                       height: 55,
//                       width: 200,
//                       child: CheckboxListTile(
//                         // shape: RoundedRectangleBorder(
//                         //     borderRadius: BorderRadius.circular(20)),
//                         title: Text(option),
//                         value: false,
//                         tileColor: Colors.amber,
//                         onChanged: (value) {},
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       },
//       child: Text("test"),
//     );
//   }
// }
