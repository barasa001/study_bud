import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageChat extends StatefulWidget {
  @override
  _HomePageChatState createState() => _HomePageChatState();
}

class _HomePageChatState extends State<HomePageChat> {
  TextEditingController _messageController = TextEditingController();
  List<String> _users = [];
  Map<String, dynamic>? _currentUserData;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadCurrentUser();
  }

  Future<void> _loadUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await FirebaseFirestore
              .instance
              .collection('users')
              .where('uid',
                  isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();

      setState(() {
        _users = usersSnapshot.docs
            .map((doc) => "${doc['fullName']} - ${doc['specialization']}")
            .toList();
      });
    } catch (e) {
      print("Error loading users: $e"); // Check for errors during user loading
    }
  }

  Future<void> _loadCurrentUser() async {
    try {
      print('Current user UID: ${FirebaseAuth.instance.currentUser!.uid}');
      DocumentSnapshot<Map<String, dynamic>> currentUserSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
      print('currentUserSnapshot.data(): ${currentUserSnapshot.data()}');

      setState(() {
        _currentUserData = currentUserSnapshot.data();
      });

      if (_currentUserData != null) {
        print('Current user data loaded successfully'); // Add success message
      } else {
        print('Current user data is null'); // Check if user data is null
      }
    } catch (e) {
      print(
          "Error loading current user: $e"); // Check for errors during user loading
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthService().signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _currentUserData != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${_currentUserData!['fullName']}!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('School: ${_currentUserData!['school']}'),
                          Text(
                            'Specialization: ${_currentUserData!['specialization']}',
                          ),
                          Text('Level: ${_currentUserData!['level']}'),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          _buildUserList(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('participants',
                      arrayContains: FirebaseAuth.instance.currentUser!.uid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    var message =
                        messages[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(message['sender']),
                      subtitle: Text(message['text']),
                    );
                  },
                );
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement logic to send a message to the selected user
                print('Sending message to ${_users[index]}');
              },
              child: Text(_users[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'text': messageText,
        'sender': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': FieldValue.serverTimestamp(),
        'participants': [FirebaseAuth.instance.currentUser!.uid],
      });
      _messageController.clear();
    }
  }
}
