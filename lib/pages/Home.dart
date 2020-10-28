import 'package:flutter/material.dart';
import 'package:reciclame/views/HomeView.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = [
    Text('Take Photo'),
    HomeView(),
    Text('News')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RECICLAME'),
        centerTitle: true,
        actions: [
          IconButton(
              icon:Icon(Icons.settings),
              onPressed: (){
              Navigator.pushNamed(context, '/settings');
          })

        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'News',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}


