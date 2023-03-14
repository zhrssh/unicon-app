import 'package:flutter/material.dart';
import 'package:untitled/constants/navigation_routes.dart';
import 'package:untitled/constants/published_projects.dart';
import '../constants/navigation_drawer.dart';
import '/constants/projects_data.dart';
// import 'package:untitled/views/calendar.dart';
// import 'package:untitled/views/location.dart';
// import 'package:untitled/views/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(
                    right: 15 + MediaQuery.of(context).padding.right),
                icon: SizedBox(
                  height: 30,
                  child: Image.asset('assets/icons/notification.png'),
                ),
                onPressed: () => navigateToNotification(context),
              )
            ],
            title: Column(
              children: const <Widget>[
                Text('Current Location'),
              ],
            ),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color.fromARGB(255, 84, 122, 70),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  readOnly: true,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white54,
                    ),
                    hintText: "Search for workers",
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: SearchPageDelegate(),
                    );
                  },
                ),
              ),
            ),
          ),
          backgroundColor: Colors.grey[50],
          drawer: const CustomNavigationDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15.0,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Published Projects",
                        style: TextStyle(
                          color: Color.fromARGB(200, 18, 13, 38),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(100, 84, 122, 70),
                            ),
                          ),
                          onPressed: () {
                            // ignore: avoid_print
                            print("See all button pressed.");
                          },
                          child: Row(
                            children: [
                              const Text(
                                "See All",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Image.asset("assets/icons/arrow_right.png"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ProjectList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchPageDelegate extends SearchDelegate {

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null), // close searchbar
        icon: const Icon(
          Icons.arrow_back,
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            // query is empty, then close search page
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> list = ['Juan Dela Cruz', 'Lebron James', 'Ryza Mae Dizon'];

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final worker = list[index];
        return ListTile(
            title: Text(worker),
            onTap: () {
              query = worker;
            });
      },
    );
  }
}
