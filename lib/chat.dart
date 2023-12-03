import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> _usernames = [
    'Seth Barasa',
    'Kenzo Niragire',
    'Joak Deng',
    'Almarat Ngutulu',
    'Astro Booysen'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _usernames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_usernames[index]),
                  onTap: () {
                    _startChatWithUser(_usernames[index]);
                  },
                );
              },
            ),
          ),
          // Input field for typing messages
          _buildInputField(),
        ],
      ),
    );
  }

  void _startChatWithUser(String username) {
    // Implement logic to start a chat with the selected user
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(username: username),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Implement message sending logic here
            },
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String username;

  ChatScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $username'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Chatting with $username'),
      ),
    );
  }
}
