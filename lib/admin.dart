import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          List<Widget> userWidgets = [];
          for (var user in users) {
            var userData = user.data() as Map<String, dynamic>;
            userWidgets.add(Card(
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
                      onPressed: () {
                        // Navigate to an update page with userData for editing
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdatePage(userData),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Implement delete functionality for this user
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.id)
                            .delete()
                            .then((value) {
                          // Deletion successful
                          print('User deleted');
                        }).catchError((error) {
                          // Handle any errors that occur during deletion
                          print('Error: $error');
                        });
                      },
                    ),
                  ],
                ),
              ),
            ));
          }
          return ListView(
            children: userWidgets,
          );
        },
      ),
    );
  }
}

class UpdatePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  UpdatePage(this.userData);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  // Controller variables for editing fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController levelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controller values with the userData
    emailController.text = widget.userData['Email'];
    fullNameController.text = widget.userData['FullName'];
    schoolController.text = widget.userData['School'];
    specializationController.text = widget.userData['Specialization'];
    levelController.text = widget.userData['Level'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Update User Data',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: schoolController,
                decoration: InputDecoration(labelText: 'School'),
              ),
              TextFormField(
                controller: specializationController,
                decoration: InputDecoration(labelText: 'Specialization'),
              ),
              TextFormField(
                controller: levelController,
                decoration: InputDecoration(labelText: 'Level'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Implement update functionality here
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userData['Email'])
                      .update({
                    'Email': emailController.text,
                    'FullName': fullNameController.text,
                    'School': schoolController.text,
                    'Specialization': specializationController.text,
                    'Level': levelController.text,
                  }).then((value) {
                    // Data updated successfully
                    Navigator.pop(context); // Go back to the admin page
                  }).catchError((error) {
                    // Handle any errors that occur during the update
                    print('Error: $error');
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: Text('UPDATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
