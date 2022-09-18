import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:notesapp/domain/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    void signOut() {
      context.read<FirebaseAuthMethods>().signOut(context);
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            LineIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            // SizedBox(
            //   child: Card(
            //     child: ListTile(
            //       // leading: Image.asset(user!.photoURL!),
            //       title: Text(user!.displayName!),
            //       trailing: Icon(Icons.arrow_forward_ios),
            //     ),
            //   ),
            // ),
            SizedBox(
              child: Card(
                child: ListTile(
                  title: const Text('Email'),
                  // subtitle: Text(user!.email!),
                ),
              ),
            ),
            SizedBox(
              child: Card(
                child: ListTile(
                  title: const Text('Phone Number'),
                  // subtitle: Text(userphoneNumber!),
                ),
              ),
            ),
            SizedBox(
          child: Card(
            child: ListTile(
              title: const Text('Log Out'),
              subtitle: Text('You are logged in with ${user.email}'),
              onTap: signOut,
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
