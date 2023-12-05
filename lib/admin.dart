import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var users = snapshot.data!.docs;
          return ListView(
            children: users.map((user) {
              var userData = user.data() as Map<String, dynamic>;
              return UserCard(
                  userData: userData,
                  onDelete: () {
                    deleteUserData(user.id);
                  },
                  onEdit: () {
                    showEditDialog(userData, user.id);
                  });
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> showEditDialog(
      Map<String, dynamic> userData, String userId) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: userData['Email'],
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  userData['Email'] = value;
                },
              ),
              TextFormField(
                initialValue: userData['FullName'],
                decoration: InputDecoration(labelText: 'Full Name'),
                onChanged: (value) {
                  userData['FullName'] = value;
                },
              ),
              TextFormField(
                initialValue: userData['School'],
                decoration: InputDecoration(labelText: 'School'),
                onChanged: (value) {
                  userData['School'] = value;
                },
              ),
              TextFormField(
                initialValue: userData['Specialization'],
                decoration: InputDecoration(labelText: 'Specialization'),
                onChanged: (value) {
                  userData['Specialization'] = value;
                },
              ),
              TextFormField(
                initialValue: userData['Level'],
                decoration: InputDecoration(labelText: 'Level'),
                onChanged: (value) {
                  userData['Level'] = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateUserData(userId, userData);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void updateUserData(String userId, Map<String, dynamic> userData) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(userData)
        .then((value) {
      // Data updated successfully
      print('User data updated');
    }).catchError((error) {
      // Handle any errors that occur during the update
      print('Error: $error');
    });
  }

  void deleteUserData(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .delete()
        .then((value) {
      // Deletion successful
      print('User deleted');
    }).catchError((error) {
      // Handle any errors that occur during deletion
      print('Error: $error');
    });
  }
}

class UserCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  UserCard({
    required this.userData,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Email: ${userData['Email']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Full Name: ${userData['FullName']}'),
            Text('School: ${userData['School']}'),
            Text('Specialization: ${userData['Specialization']}'),
            Text('Level: ${userData['Level']}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
