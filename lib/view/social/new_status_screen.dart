// import 'package:flutter/material.dart';

// class NewStatusScreen extends StatefulWidget {
//   @override
//   _NewStatusScreenState createState() => _NewStatusScreenState();
// }

// class _NewStatusScreenState extends State<NewStatusScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Status'),
//       ),
//       body: Column(
//         children: [
//           // Status input form
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Type your status here',
//               ),
//             ),
//           ),
//           // Add media options (e.g., camera/gallery buttons)
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement posting the status to Firestore or your database
//           // and navigate back to the status screen
//           Navigator.pop(context);
//         },
//         child: Icon(Icons.send), // Send status icon
//       ),
//     );
//   }
// }
