import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

    int selected = 0;
    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static const List<Widget> _widgetOptions = <Widget>[
          Text(
            'Index 0: Home',
            style: optionStyle,
          ),
          Text(
            'Index 1: Search',
            style: optionStyle,
          ),
          Text(
            'Index 2: Bookmarks',
            style: optionStyle,
          ),
        ];
    void _onItemTapped(int index) {
      switch(index){
        case 0:
          Navigator.pushNamed(context, '/');
          break;
        case 1:
          FirebaseAuth.instance.signOut();
          break;
        case 2:
          Navigator.pushNamed(context, '/bookmarks');
          break;
      }

    }
    @override
    Widget build(BuildContext context){
      var size = MediaQuery.of(context).size;
      final ButtonStyle leadingStyle = ElevatedButton.styleFrom(
      primary: Colors.black,
      minimumSize: Size(400, size.height * 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 25,
    );
      
        return SafeArea(
          child: Scaffold(
              body: SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text('Good Morning',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          //create a profile button
                          SizedBox(
                            width: size.width * 0.5,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.person),
                          )

                        ],
                      ),
                    ),
                    

                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home,color: Colors.black,size: 45,),
                          label: 'Home',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search,color: Colors.black,size: 45,),
                          label: 'Search',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.bookmark,color: Colors.black,size: 45,),
                          label: 'Bookmarks',
                          
                      ),
                  ],
                  currentIndex: selected,
                  selectedItemColor: Colors.black,
                  onTap: _onItemTapped,
                  
                  )
                  //
              ),
        );
    }

}