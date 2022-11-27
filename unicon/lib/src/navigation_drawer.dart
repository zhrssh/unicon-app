import 'package:flutter/material.dart';

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

  Widget buildHeader(BuildContext context) => Container(
        // color: const Color.fromARGB(255, 84, 122, 70),
        color: const Color.fromARGB(255, 84, 122, 70),
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/8a/63/04/8a6304985aa67c8133bf8881256d31be.jpg'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Nino Nakano',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Text(
              'ninonakano@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
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
            Container(
              height: 25,
            ),
            const Divider(color: Colors.black38),
            Container(
              height: 25,
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
              onTap: () {},
            ),
          ],
        ),
      );
}
