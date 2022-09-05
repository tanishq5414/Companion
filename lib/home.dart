import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

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
          Navigator.pushNamed(context, '/search');
          break;
        case 2:
          Navigator.pushNamed(context, '/bookmarks');
          break;
      }

    }
    @override
    Widget build(BuildContext context){
        return Scaffold(
            body: Center(
                child: _widgetOptions.elementAt(selected),
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
            );
    }

}