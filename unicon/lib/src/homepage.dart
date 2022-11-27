import 'package:flutter/material.dart';
import 'package:unicon/src/placeholder.dart';
import 'navigation_drawer.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(
                right: 15 + MediaQuery.of(context).padding.right),
            icon: SizedBox(
              height: 30,
              child: Image.asset('assets/icons/notification.png'),
            ),
            onPressed: () {},
          )
        ],
        title: const Text('Current Location'),
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 84, 122, 70),
      ),
      backgroundColor: Colors.grey[50],
      drawer: const NavigationDrawer(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              // Placeholder
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(color: Colors.red[600]),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Tiles();
                }),
          )
        ],
      ),
    );
  }
}

class TabletPage extends StatefulWidget {
  const TabletPage({super.key});

  @override
  State<TabletPage> createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DesktopPage extends StatefulWidget {
  const DesktopPage({super.key});

  @override
  State<DesktopPage> createState() => _DesktopPageState();
}

class _DesktopPageState extends State<DesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
