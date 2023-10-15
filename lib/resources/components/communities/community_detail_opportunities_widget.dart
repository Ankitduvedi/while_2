import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Opportunity {
  final String name;
  final String description;
  final String url;

  Opportunity({required this.name, required this.description, required this.url});
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class OpportunitiesScreen extends StatefulWidget {
  const OpportunitiesScreen({super.key});
  @override
  OpportunitiesScreenState createState() => OpportunitiesScreenState();
}

class OpportunitiesScreenState extends State<OpportunitiesScreen> {
  
Future<void> _showOpportunityDetails(Opportunity opportunity) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          opportunity.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              opportunity.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16),
            const Text(
              'URL:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              child: Text(
                opportunity.url,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue, // Add a link-like color
                ),
              ),
              onTap: () {
                // Handle URL click, e.g., open the URL in a web browser
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Opportunities'),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('opportunities').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No opportunities available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final opportunity = Opportunity(
                name: data['name'],
                description: data['description'],
                url: data['url'],
              );

              return ListTile(
                title: Text(opportunity.name),
                subtitle: Text(opportunity.description),
                onTap: () {
                  _showOpportunityDetails(opportunity);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen where admins can add opportunities
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddOpportunityScreen()));
        },
        tooltip: 'Add Opportunity',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddOpportunityScreen extends StatefulWidget {
  const AddOpportunityScreen({super.key});
  @override
  AddOpportunityScreenState createState() => AddOpportunityScreenState();
}

class AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Opportunity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Opportunity Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Opportunity Description'),
            ),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'Opportunity URL'),
            ),
            ElevatedButton(
              onPressed: () {
                // Upload the new opportunity to Firestore
                _uploadOpportunity();
                Navigator.pop(context);
              },
              child: const Text('Add Opportunity'),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadOpportunity() {
    final newOpportunity = Opportunity(
      name: nameController.text,
      description: descriptionController.text,
      url: urlController.text,
    );

    _firestore.collection('opportunities').add({
      'name': newOpportunity.name,
      'description': newOpportunity.description,
      'url': newOpportunity.url,
    }).then((_) {
      // After successful upload, clear the text fields
      nameController.clear();
      descriptionController.clear();
      urlController.clear();
    });
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: OpportunitiesScreen(),
//   ));
// }
