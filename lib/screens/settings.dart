import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            LineIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              child: Card(
                child: ListTile(
                  // leading: Image.asset(user!.photoURL!),
                  title: Text(user!.displayName!),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            SizedBox(
              child: Card(
                child: ListTile(
                  title: const Text('Email'),
                  subtitle: Text(user.email!),
                ),
              ),
            ),
            SizedBox(
              child: Card(
                child: ListTile(
                  title: const Text('Phone Number'),
                  // subtitle: Text(user!.phoneNumber!),
                ),
              ),
            ),
            SizedBox(
          child: Card(
            child: ListTile(
              title: const Text('Log Out'),
              subtitle: Text('You are logged in with ${user.email}'),
              onTap: FirebaseAuth.instance.signOut,
            ),
          ),
        ),
        Spacer(),
        SizedBox(
          child: Card(
            child: ListTile(
              title: const Text('Earn Money'),
              subtitle: Text('Upload Notes and Earn Money'),
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.1,
        )
          ],
        ),
      ),
    );
  }
}
