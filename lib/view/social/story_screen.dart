import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late Stream<QuerySnapshot> peopleStream;
  late Stream<QuerySnapshot> pagesStream;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize Firestore streams
    peopleStream = FirebaseFirestore.instance.collection('users').snapshots();
    pagesStream =
        FirebaseFirestore.instance.collection('communities').snapshots();

    // Initialize the TabController
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose the TabController
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            text: 'People',
          ),
          Tab(
            text: 'Communities',
          ),
        ],
        labelColor: Colors.black, // Set the text color of the selected tab
        unselectedLabelColor:
            Colors.grey, // Set the text color of unselected tabs
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPeopleTab(),
          _buildPagesTab(),
        ],
      ),
    );
  }

  Widget _buildPeopleTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'People to Follow:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: peopleStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final peopleDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: peopleDocs.length,
                itemBuilder: (context, index) {
                  final person =
                      peopleDocs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          person['image']), // Add the profile image URL
                    ),
                    title: Text(person['name']),
                    subtitle: Text(person['email']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implement the follow functionality for people here
                        // You can add the person to your list of followed people in Firestore
                      },
                      child: const Text('Follow'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPagesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Communities to join:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: pagesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final pagesDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: pagesDocs.length,
                itemBuilder: (context, index) {
                  final page = pagesDocs[index].data() as Map<String, dynamic>;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          page['image']), // Add the profile image URL
                    ),
                    title: Text(page['name']),
                    subtitle: Text(page['domain']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implement the follow functionality for pages here
                        // You can add the page to your list of followed pages in Firestore
                      },
                      child: Text('Follow'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
