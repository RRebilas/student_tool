import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenttool/authenticate/authenticate.dart';
import 'package:studenttool/models/ToDoModel.dart';
import 'package:studenttool/models/user.dart';
import 'package:studenttool/widgets/Blueprint.dart';
import 'package:studenttool/widgets/Home.dart';
import 'package:studenttool/widgets/Schedule.dart';

import 'ToDo.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  PageController _controller = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentNavigationBarIndex = 0;
  final Authentication _auth = Authentication();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUser>();

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Blueprint(title: 'Home', body: HomeScreen()),
          Blueprint(title: 'Schedule', body: Schedule()),
          ChangeNotifierProvider<ToDoModel>(
            create: (context) => ToDoModel(),
            child: ToDo(),
          ),
          //TODO: implement user-info page
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Nazwa: ${user.email}"),
                RaisedButton(
                  child: Text('Wyloguj'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
          //Blueprint(title: 'Profile Page', body: Container()),
        ],
        onPageChanged: (page) {
          setState(
            () {
              currentNavigationBarIndex = page;
            },
          );
        },
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }

  Widget get bottomNavBar {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentNavigationBarIndex,
      backgroundColor: Colors.deepOrange.shade800,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      onTap: (index) => setState(() {
        currentNavigationBarIndex = index;
        _controller.jumpToPage(currentNavigationBarIndex);
      }),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          // ignore: deprecated_member_use
          title: Text('Home'),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Schedule'),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted), label: 'To Do'),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.w3schools.com/howto/img_avatar.png'),
              radius: 20,
            ),
            label: 'Profile'),
      ],
    );
  }
}
