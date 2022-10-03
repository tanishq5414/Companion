//flutter screen with a search bar
import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Search',
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                const SearchBar(),
                SizedBox(height: size.height * 0.05),

                // SearchResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.035),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/mainsearch');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.search, color: appGreyColor),
            Spacer(),
            Center(child: Text('Search notes, courses, etc.', style: TextStyle(color: appGreyColor, fontSize: 15, fontWeight: FontWeight.bold))),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
