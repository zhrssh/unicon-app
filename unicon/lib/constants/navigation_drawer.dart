import 'package:flutter/material.dart';
import 'navigation_routes.dart';
import 'top_bottom_clippings.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/8a/63/04/8a6304985aa67c8133bf8881256d31be.jpg'),
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: SizedBox(
                            height: 20,
                            width: 150,
                            child: Text(
                              "Andrew Tate",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 2,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: SizedBox(
                            height: 15,
                            width: 150,
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(150, 78, 112, 67)
                                  // fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
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
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/inbox.png'),
                  ),
                  title: const Text('Inbox'),
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/calendar.png'),
                  ),
                  title: const Text('Calendar'),
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/helpdesk.png'),
                  ),
                  title: const Text('Help Desk'),
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/settings.png'),
                  ),
                  title: const Text('Settings'),
                  onTap: () {},
                ),
                // Place holder
                // Container(
                //   height: 50,
                // ),
                // const Divider(color: Colors.black38),
                Container(
                  height: 200,
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/faqs.png'),
                  ),
                  title: const Text('Helps & FAQS'),
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                    height: 30,
                    child: Image.asset('assets/icons/signout.png'),
                  ),
                  title: const Text('Signout'),
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
