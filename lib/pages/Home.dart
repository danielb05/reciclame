import 'package:flutter/material.dart'
    show
        AppBar,
        BottomNavigationBar,
        BottomNavigationBarItem,
        BottomNavigationBarType,
        BuildContext,
        Center,
        Icon,
        Icons,
        Key,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;
import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      Text('Scan Object'),
      Text('Location'),
      Text('List'),
      Text('List'),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'title').toUpperCase()),
        centerTitle: true,
        actions: [
          Padding(padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/settings');
            },
            child: Icon(Icons.settings,size: 26.0),
          ),)
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
