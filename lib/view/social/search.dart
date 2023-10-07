// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:while_app/view_model/current_user_provider.dart';

// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   late String name = '';
//   late String uid = '';
//   late String alreadyFriend = '';
//   late Set<String> followedUserIds = {}; // Store followed user IDs in a Set

//   @override
//   void initState() {
//     super.initState();
//     // Fetch followed users once and store their UIDs in the Set
//     fetchFollowedUsers();
//   }

//   Future<void> fetchFollowedUsers() async {
//     final userProvider =
//         Provider.of<CurrentUserProvider>(context, listen: false);

//     final followingCollection = FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userProvider.user.uid)
//         .collection('following');

//     final querySnapshot = await followingCollection.get();

//     // Extract UIDs and store them in the Set
//     final uids = querySnapshot.docs.map((doc) => doc['uid']).toList();
//     setState(() {
//       followedUserIds = Set.from(uids);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<CurrentUserProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Card(
//           child: TextField(
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.search),
//               hintText: 'Search...',
//             ),
//             onChanged: (val) {
//               setState(() {
//                 name = val;
//               });
//             },
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('Users').snapshots(),
//         builder: (context, snapshots) {
//           if (snapshots.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshots.data!.docs.length,
//             itemBuilder: (context, index) {
//               final data =
//                   snapshots.data!.docs[index].data() as Map<String, dynamic>;

//               return buildUserListTile(data, userProvider);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget buildUserListTile(
//       Map<String, dynamic> data, CurrentUserProvider userProvider) {
//     final isFollowing =
//         followedUserIds.contains(data['id']); // Check if user is followed

//     return name.isEmpty ||
//             data['name'].toString().toLowerCase().startsWith(name.toLowerCase())
//         ? ListTile(
//             onTap: () => handleUserTap(data, userProvider, isFollowing),
//             title: Text(
//               data['name'],
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 color: Colors.black54,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             subtitle: Text(
//               data['email'],
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 color: Colors.black54,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(data['profile']),
//             ),
//             trailing: OutlinedButton(
//               onPressed: () => handleTrailingButtonTap(isFollowing),
//               child: Text(isFollowing ? 'Message' : 'Follow'),
//             ),
//           )
//         : const SizedBox.shrink(); // Hide if name doesn't match
//   }

//   void handleUserTap(Map<String, dynamic> data,
//       CurrentUserProvider userProvider, bool isFollowing) {
//     if (isFollowing) {
//       // User is already followed, navigate to the message detail screen
//       navigateToMessageDetail(data, userProvider);
//     } else {
//       // User is not followed, handle the follow action
//       followUser(data, userProvider);
//     }
//   }

//   void navigateToMessageDetail(
//       Map<String, dynamic> data, CurrentUserProvider userProvider) {
//     // Implement navigation to the message detail screen
//   }

//   void followUser(Map<String, dynamic> data, CurrentUserProvider userProvider) {
//     // Implement the follow user action

//     // Update the UI and add the user to the followedUserIds Set
//     setState(() {
//       followedUserIds.add(data['id']);
//     });
//   }

//   void handleTrailingButtonTap(bool isFollowing) {
//     if (isFollowing) {
//       // Handle the message action
//     } else {
//       // Handle the follow action
//     }
//   }
// }
