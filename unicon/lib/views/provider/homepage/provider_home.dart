import 'package:flutter/material.dart';

//import 'calendar.dart';
import '../provider_navigation_routes.dart';
import 'provider_dashboard.dart';
//import 'location.dart';
import 'provider_profile.dart';

class ProviderHome extends StatefulWidget {
  final String token;
  const ProviderHome({super.key, required this.token});

  @override
  State<ProviderHome> createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  int currentTab = 0; // counter current tab

  // different views/bottomNavBar item
  late final List<Widget> screens = [
    ProviderDashboard(token: widget.token),
    //CalendarPage(),
    //LocationPage(),
    ProviderProfilePage(token: widget.token)
  ];

  late Widget currentScreen =
      ProviderDashboard(token: widget.token); // sets current view

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
        onPressed: () {},
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
                      currentScreen = ProviderDashboard(token: widget.token);
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
                      //currentScreen = CalendarPage();
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
                      //currentScreen = LocationPage();
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
                      navigateToProfilePage(context, widget.token);
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
