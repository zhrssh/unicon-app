import 'package:flutter/material.dart';

import '../../constants/navigation_routes.dart';
import '../calendar.dart';
import '../dashboard.dart';
import '../location.dart';
import '../profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0; // counter current tab

  // different views/bottomNavBar item
  final List<Widget> screens = [
    const Dashboard(),
    const CalendarPage(),
    const LocationPage(),
    const ProfilePage(),
  ];

  Widget currentScreen = const Dashboard(); // sets current view

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 84, 122, 70), // green bg
        onPressed: () {
          navigateToPublishProjectPage(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const Dashboard();
                      currentTab = 0;
                    });
                  }),
                  icon: Icon(
                    Icons.home,
                    color: currentTab == 0
                        ? const Color.fromARGB(255, 84, 122, 70)
                        : Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const CalendarPage();
                      currentTab = 1;
                    });
                  }),
                  icon: Icon(
                    Icons.calendar_month,
                    color: currentTab == 1
                        ? const Color.fromARGB(255, 84, 122, 70)
                        : Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const LocationPage();
                      currentTab = 2;
                    });
                  }),
                  icon: Icon(
                    Icons.location_pin,
                    color: currentTab == 2
                        ? const Color.fromARGB(255, 84, 122, 70)
                        : Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const ProfilePage();
                      currentTab = 3;
                    });
                  }),
                  icon: Icon(
                    Icons.people,
                    color: currentTab == 3
                        ? const Color.fromARGB(255, 84, 122, 70)
                        : Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
              ]),
        ),
      ),
    );
  }
}
