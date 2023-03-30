import 'package:flutter/material.dart';
import '../../constants/top_bottom_clippings.dart';
import 'client_navigation_routes.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final String token;
  final String name;
  final String email;
  const CustomNavigationDrawer(
      {super.key,
      required this.token,
      required this.name,
      required this.email});

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Column(
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: ClipPath(
                  clipper: TopClipPath(),
                  child: Container(
                    color: const Color.fromARGB(255, 84, 122, 70),
                    height: 50,
                  ),
                ),
              ),
              ClipPath(
                clipper: TopClipPath(),
                child: Container(
                  color: const Color.fromARGB(150, 78, 112, 67),
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                    CircleAvatar(
                      radius: 40,
                      child:
                          Image.asset('assets/images/profile-placeholder.png'),
                      // backgroundImage: NetworkImage(
                      //     'https://i.pinimg.com/originals/8a/63/04/8a6304985aa67c8133bf8881256d31be.jpg'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 150,
                              child: Text(
                                widget.name, // Text for profile name
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 15,
                              width: 150,
                              child: Text(
                                widget.email, // Text for email name
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black38
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );

  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              runSpacing: 2,
              children: [
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/profile.png'),
                  ),
                  title: const Text('My Profile'),
                  onTap: () =>
                      navigateToClientProfilePage(context, widget.token),
                ),
                ListTile(
                    leading: SizedBox(
                      height: 30,
                      child: Image.asset('assets/icons/inbox.png'),
                    ),
                    title: const Text('Inbox'),
                    onTap: () =>
                        navigateToClientChatPage(context, widget.token)),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/calendar.png'),
                  ),
                  title: const Text('Calendar'),
                  onTap: () =>
                      navigateToClientCalendarPage(context, widget.token),
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/settings.png'),
                  ),
                  title: const Text('Settings'),
                  onTap: () => navigateToNotificationSettingsPage(context),
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/signout.png'),
                  ),
                  title: const Text('Log Out'),
                  onTap: () {
                    navigateToLoginPage(context);
                  },
                ),
              ],
            ),
          ),
        ],
      );
}
