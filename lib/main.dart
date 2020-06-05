import 'package:provider/provider.dart';
import 'package:studenttool/models/ToDoModel.dart';
import 'screens/auth_page.dart';

import 'index.dart';

void main() => runApp(StudentTool());

class StudentTool extends StatefulWidget {
  @override
  _StudentToolState createState() => _StudentToolState();
}

class _StudentToolState extends State<StudentTool> {
  PageController _controller = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentNavigationBarIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple.shade900,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        body: PageView(
          controller: _controller,
          children: <Widget>[
            Blueprint(title: 'Home', body: HomeScreen()),
            Blueprint(title: 'Schedule', body: Schedule()),
            ChangeNotifierProvider<ToDoModel>(
              create: (context) => ToDoModel(),
              child: Blueprint(
                title: 'To Do',
                body: ToDo(),
              ),
            ),
            //Blueprint(title: 'Profile Page', body: Container()),
            AuthPage(),
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
      ),
    );
  }

  Widget get bottomNavBar {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentNavigationBarIndex,
      backgroundColor: Colors.deepPurple.shade900,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      onTap: (index) => setState(() {
        currentNavigationBarIndex = index;
        _controller.jumpToPage(currentNavigationBarIndex);
      }),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Schedule'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          title: Text('To Do'),
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundImage:
                NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
            radius: 20,
          ),
          title: Text('Profile'),
        ),
      ],
    );
  }
}
