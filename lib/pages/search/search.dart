//flutter screen with a search bar
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_left_outlined)),
            ),
            body: Center(
              child: Text('Search'),
            ),
          ),
        );
      },
    );
  }
}
