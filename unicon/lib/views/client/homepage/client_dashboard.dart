import 'dart:convert';
import '../../workerProfiles/worker_profile1.dart';
import '../../workerProfiles/worker_profile2.dart';
import '../../workerProfiles/worker_profile3.dart';
import '../../workerProfiles/worker_profile4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
// import 'package:untitled/constants/navigation_routes.dart';
import 'package:untitled/views/client/homepage/client_published_projects.dart';
import 'package:untitled/views/worker_model.dart';
import '../client_navigation_drawer.dart';
import '../client_navigation_routes.dart';
import '/constants/projects_data.dart';
// import 'package:untitled/views/calendar.dart';
// import 'package:untitled/views/location.dart';
// import 'package:untitled/views/profile.dart';

class ClientDashboard extends StatefulWidget {
  final String token;
  const ClientDashboard({super.key, required this.token});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  Future<http.Response> _getUserInfo() async {
    final uri = Uri.parse('http://${dotenv.env["RSC_URL"]}/api/client/profile');
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder(
          future: _getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      height: 200,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 200,
                  ),
                  Text('${snapshot.error}'),
                ],
              ));
            } else {
              final response = snapshot.data as http.Response;
              final user = json.decode(response.body);

              return Scaffold(
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
                    children: <Widget>[
                      Text("Hi, ${user["name"]["firstName"]}!"),
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
                drawer: CustomNavigationDrawer(
                  token: widget.token,
                  email: user["email"],
                  name:
                      "${user["name"]["firstName"]} ${user["name"]["lastName"]}",
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 15.0,
                  ),
                  child: SingleChildScrollView(
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
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                      (states) => const Color.fromARGB(
                                          100, 84, 122, 70),
                                    ),
                                  ),
                                  onPressed: () =>
                                      navigateToClientCalendarPage(context),
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
                                      Image.asset(
                                          "assets/icons/arrow_right.png"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 440,
                          child: ClientProjectList(),
                        ),
                        // SizedBox(
                        //   height: 300,
                        //   child: ProjectList(),
                        // )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SearchPageDelegate extends SearchDelegate {
  static List<Worker> workersList = [
    Worker('Juan Dela Cruz', 'Painter', 'Quezon City'),
    Worker('Wally Bayola', 'Carpenter', 'Quezon City'),
    Worker('Crisostomo Ibarra', 'Welder', 'Quezon City'),
    Worker('Rendon Labador', 'Engineer', 'Pasig City'),
    Worker('Andrew Tate', 'Cool-Kid', 'US of A'),
    Worker('Albert Dela Rosa', 'Carpenter', 'Pasig City'),
  ];

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
    List<Widget> route = [
      const WorkerProfilePage1(),
      const WorkerProfilePage2(),
      const WorkerProfilePage3(),
      const WorkerProfilePage4(),
    ];
    List<Worker> displayWorkers = workersList.where((worker) {
      // if query is empty, display all workers
      if (query.isEmpty) {
        return true;
      }
      // otherwise, check if worker name or job contains query
      final name = worker.name?.toLowerCase() ?? '';
      final job = worker.job?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();
      return name.contains(queryLower) || job.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: displayWorkers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: (() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => route[index]))),
                child: Stack(
                  children: [
                    Positioned(
                      child: Material(
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                offset: const Offset(0, 4),
                                blurRadius: 3.0,
                                spreadRadius: 2.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 5,
                      top: 10,
                      height: 100,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Text(
                          "Insert image here",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 150,
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayWorkers[index].name!.toUpperCase(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 84, 122, 70),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              displayWorkers[index].job!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              displayWorkers[index].location!.toUpperCase(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 84, 122, 70),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
