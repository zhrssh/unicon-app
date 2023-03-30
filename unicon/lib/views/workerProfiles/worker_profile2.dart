import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//Wally Bayola
class WorkerProfilePage2 extends StatefulWidget {
  const WorkerProfilePage2({super.key});

  @override
  State<WorkerProfilePage2> createState() => _WorkerProfilePageState2();
}

class _WorkerProfilePageState2 extends State<WorkerProfilePage2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _hasBeenPressed = false;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        leadingWidth: 30,
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 40,
            child: Image.asset('assets/images/profile-placeholder.png'),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Wally Bayola - Carpenter",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 25,
            onRatingUpdate: (rating) {},
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                width: 110,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: _hasBeenPressed
                          ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 100, 168, 73))
                          : MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 84, 122, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 84, 122, 70))))),
                  onPressed: () => setState(
                    () {
                      _hasBeenPressed = !_hasBeenPressed;
                    },
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      _hasBeenPressed
                          ? const Text("Following",
                              style: TextStyle(fontSize: 11))
                          : const Text("Follow",
                              style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 45,
                width: 110,
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 84, 122, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 84, 122, 70))))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      const Text("Message", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 45,
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color.fromARGB(255, 84, 122, 70),
              indicatorPadding: const EdgeInsets.all(5.0),
              labelColor: const Color.fromARGB(255, 84, 122, 70),
              unselectedLabelColor: Colors.grey.shade500,
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const Tab(
                  child: Text(
                    "ABOUT",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Tab(
                  child: Text(
                    "PROJECTS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Tab(
                  child: Text(
                    "REVIEWS",
                    style: TextStyle(
                      fontSize: 12,
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
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Hi! I\'m arguably the best Carpenter in the Philppines. Hit me up!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ListView(
                  children: [
                    _buildProjects(
                        image: 'assets/images/OfferServices.png',
                        title: 'Carpentry in the hood',
                        date: 'December 2021'.toUpperCase()),
                    _buildProjects(
                        image: 'assets/images/IndividualService.png',
                        title: 'House Renovation',
                        date: 'November 2021'.toUpperCase())
                  ],
                ),
                ListView(
                  children: [
                    _buildReviews(
                        image: 'assets/images/profile-placeholder.png',
                        name: 'John Michael',
                        body: 'Always on time and answer calls all the time.',
                        rating: 5.0,
                        date: '30 Dec'),
                    _buildReviews(
                        image: 'assets/images/profile-placeholder.png',
                        name: 'Jonah Robert Hill',
                        body: 'My Idol',
                        rating: 5.0,
                        date: '29 Jan'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProjects({
  required String image,
  required String title,
  required String date,
}) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(15),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: Image.asset(
              image,
              height: 40,
              width: 40,
              fit: BoxFit.fill,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
          Expanded(
            // width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 122, 70),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildReviews({
  required String image,
  required String name,
  required String body,
  required String date,
  required double rating,
}) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(15),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 15,
              child: Image.asset(image),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            // width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 10.0,
                ),
                const SizedBox(height: 5),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Text(
            date,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600),
          )
        ],
      ),
    ),
  );
}
