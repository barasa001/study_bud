import 'package:flutter/material.dart';
import 'auth_service.dart'; // Import authentication service

class HomePageChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout here
              AuthService().signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a chat...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    // Placeholder avatar, replace with your own logic
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  title: Text('User 1'),
                  subtitle: Text('Last message from User 1'),
                  onTap: () {
                    // Open the chat with User 1
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    // Placeholder avatar
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  title: Text('User 2'),
                  subtitle: Text('Last message from User 2'),
                  onTap: () {
                    // Open the chat with User 2
                  },
                ),
                // Add more chat entries as needed
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle creating a new chat
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
