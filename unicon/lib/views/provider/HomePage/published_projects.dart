import 'package:flutter/material.dart';
import 'projects_data.dart';

// ignore: use_key_in_widget_constructors
class ProjectList extends StatefulWidget {
  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  List<Widget> itemsData = [];

  // Function to get data from projects_data.dart
  void getProjectsData() {
    List<dynamic> responseList = projectData;
    List<Widget> listItems = [];
    for (var project in responseList) {
      listItems.add(
        InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Positioned(
                child: Material(
                  child: Container(
                    height: 280,
                    width: 400,
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
              Positioned(
                left: 10,
                top: 10,
                height: 160,
                width: 350,
                child: Card(
                  elevation: 10.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 255, 180, 89),
                      // borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: AssetImage("assets/images/${project["image"]}"),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 185,
                left: 20,
                child: SizedBox(
                  height: 100,
                  width: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${project["job_title"]}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/location.png',
                            height: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${project["location"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 105, 104, 114),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "Posted by: ${project["personPosted"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 43, 40, 73),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    getProjectsData();
    return ListView.separated(
      itemCount: itemsData.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, _) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        return itemsData[index];
      },
    );
  }
}
