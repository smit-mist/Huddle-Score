// import 'package:flutter/material.dart';
//
// import '../../constants.dart';
//
// class CustomDropDown extends StatefulWidget {
//   List<String> fields;
//   CustomDropDown({@required this.fields});
//
//   @override
//   _CustomDropDownState createState() => _CustomDropDownState();
// }
//
// class _CustomDropDownState extends State<CustomDropDown> {
//   String val = widget.fields[0];
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       validator: (value) =>
//           value == 'Select a State' ? 'Please Select a State' : null,
//       isExpanded: true,
//       focusColor: Colors.grey.withOpacity(0.14),
//       value: statee,
//       style: TextStyle(color: Colors.white),
//       icon: Icon(
//         Icons.keyboard_arrow_down,
//         color: kThemeColor,
//         size: 12,
//       ),
//       items:
//           stateCity.keys.toList().map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(
//             value,
//             style: TextStyle(color: Colors.black),
//           ),
//         );
//       }).toList(),
//       onChanged: (s) {},
//       hint: Text(
//         "State",
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }
