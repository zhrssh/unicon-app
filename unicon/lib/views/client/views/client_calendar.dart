import 'package:flutter/material.dart';
import '../models/client_calendar_model.dart';

class ClientCalendarPage extends StatefulWidget {
  const ClientCalendarPage({super.key});

  @override
  State<ClientCalendarPage> createState() => _ClientCalendarPageState();
}

class _ClientCalendarPageState extends State<ClientCalendarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        leadingWidth: 30,
        title: const Text("Calendar"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 45,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              indicatorPadding: const EdgeInsets.all(5.0),
              labelColor: const Color.fromARGB(255, 84, 122, 70),
              unselectedLabelColor: Colors.grey.shade500,
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const Tab(
                  child: Text(
                    "DEADLINES",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Tab(
                  child: Text(
                    "PAST JOBS",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: buildDeadlines(context),
                ),
                Container(
                  child: buildPastJobs(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static List<PastJobs> pastJobList = [
    PastJobs('assets/images/OfferServices.png', 'Interior Painting',
        'December 2022'),
    PastJobs('assets/images/IndividualService.png',
        'Subdivision Painting Job in Antipolo', 'November 2022'),
    PastJobs(
        'assets/images/OfferServices.png', 'Repaint my Room', 'January 2021'),
  ];

  Widget buildPastJobs(BuildContext context) {
    List<PastJobs> displayPastJobs = List.from(pastJobList);
    return ListView.builder(
        itemCount: displayPastJobs.length,
        itemBuilder: (context, index) {
          return _buildPastJobs(
              image: displayPastJobs[index].image!,
              title: displayPastJobs[index].title!,
              date: displayPastJobs[index].date!.toUpperCase());
        });
  }

  Widget _buildPastJobs({
    required String image,
    required String title,
    required String date,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              ClipRect(
                child: Image.asset(
                  image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      date,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 84, 122, 70),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<CurrentJobs> currentJobList = [
    CurrentJobs('assets/images/card1.png', 'Wall Painting (Upcoming)',
        'Quezon City, Philippines', '10', 'Jan'),
    CurrentJobs('assets/images/card2.jpg', 'House Renovation (Upcoming)',
        'San Juan City, Philippines', '31', 'Mar'),
  ];

  Widget buildDeadlines(BuildContext context) {
    List<CurrentJobs> displayDeadlines = List.from(currentJobList);
    return ListView.builder(
        itemCount: displayDeadlines.length,
        itemBuilder: (context, index) {
          return _buildDeadlines(
              image: displayDeadlines[index].image!,
              title: displayDeadlines[index].title!,
              location: displayDeadlines[index].location!,
              date: displayDeadlines[index].date!,
              month: displayDeadlines[index].month!.toUpperCase());
        });
  }

  Widget _buildDeadlines({
    required String image,
    required String title,
    required String location,
    required String date,
    required String month,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          //height: 250,
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 160,
                width: 310,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.topLeft,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          date,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          month,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              SizedBox(
                width: 310,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/location.png',
                    height: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 150, 150, 151),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
