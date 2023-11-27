// import 'package:flutter/material.dart';


// class ContainerWidget extends StatelessWidget{

//  @override
//   Widget build(BuildContext context) {
//     return Container(
//                 height: 150,
//                 child: GridView.builder(
//                   scrollDirection: Axis.horizontal,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 1,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 10.0,
//                     childAspectRatio: 9 / 12,
//                   ),
//                   itemCount: videoItems.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => VideoPlayerScreen(
//                               videoUrl: videoItems[index].videoUrl,
//                               videoTitle: videoItems[index].title,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         color: Colors.black,
//                         elevation: 4.0,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                           videoItems[index].thumbnailUrl),
//                                       fit: BoxFit.cover,
//                                     )),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 videoItems[index].title,
//                                 style: TextStyle(
//                                     fontSize: 16.0, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//   }
// }



