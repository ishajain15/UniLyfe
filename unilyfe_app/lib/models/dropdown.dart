// import 'package:flutter/material.dart';

// class DropDown extends StatefulWidget {
//   @override
//   DropDownState createState() => DropDownState();
// }

// class DropDownState extends State<DropDown> {
//   String chosenValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //appBar: AppBar(
//         //title: Text('DropDown'),
//       //),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(0.0),
//           child: DropdownButton<String>(
//             value: chosenValue,
//             //elevation: 5,
//             style: TextStyle(color: Colors.black),

//             items: <String>[
//               'Earhart Dining Court',
//               'Wiley Dining Court',
//               'Windsor Dining Court',
//               'Hillenbrand Dining Court',
//               'Earhart Hall',
//               'Wiley Residence Hall',
//               'Windsor Residence Hall'
//               'Hillenbrand Hall',
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             hint: Text(
//               "Choose a location",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600),
//             ),
//             onChanged: (String value) {
//               setState(() {
//                 chosenValue = value;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }