import 'package:flutter/material.dart';
import 'package:untitled/views/client/views/client_calendar.dart';
import '../../calendar.dart';
import '../../location.dart';
import '../chat_client/screens/chatpage.dart';
import '../client_navigation_routes.dart';
import 'client_dashboard.dart';
import 'client_profile.dart';

class ClientHome extends StatefulWidget {
  final String token;
  const ClientHome({super.key, required this.token});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int currentTab = 0; // counter current tab

  // different views/bottomNavBar item
  late final List<Widget> screens = [
    ClientDashboard(token: widget.token),
    const CalendarPage(),
    const LocationPage(),
    ClientProfilePage(token: widget.token),
  ];

  late Widget currentScreen =
      ClientDashboard(token: widget.token); // sets current view

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 84, 122, 70), // green bg
        onPressed: () => navigateToPublishProjectPage(context),
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
                      currentScreen = ClientDashboard(token: widget.token);
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
                      currentScreen = ClientCalendarPage(token: widget.token);
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
                      currentScreen = ClientChatPage(token: widget.token);
                      currentTab = 2;
                    });
                  }),
                  icon: Icon(
                    Icons.chat_rounded,
                    color: currentTab == 2
                        ? const Color.fromARGB(255, 84, 122, 70)
                        : Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = ClientProfilePage(token: widget.token);
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
