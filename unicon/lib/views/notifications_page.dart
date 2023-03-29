import 'dart:ui';

import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        leadingWidth: 30,
        title: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            const Text(
              "Notification",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: buildNotifications(context),
      ),
    );
  }

  static List<Notifications> notificationList = [
    Notifications('assets/images/OfferServices.png',
        'Jay Sonza wants to take your Job in Interior Design', 'Just Now'),
    Notifications(
        'assets/images/IndividualService.png',
        'Juan Dela Cruz finished today\'s Task in Wall Repainting',
        '5 mins ago'),
    Notifications('assets/images/FindServices.png',
        'Juan Dela Cruz timed in for Task Wall Repainting', '6 hrs ago'),
  ];

  Widget buildNotifications(BuildContext context) {
    List<Notifications> displayNotifs = List.from(notificationList);
    return ListView.builder(
        itemCount: displayNotifs.length,
        itemBuilder: (context, index) {
          return _buildNotificationBox(
              image: displayNotifs[index].image!,
              title: displayNotifs[index].title!,
              time: displayNotifs[index].time!);
        });
  }

  Widget _buildNotificationBox({
    required String image,
    required String title,
    required String time,
  }) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                image,
                height: 70,
                width: 70,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
            SizedBox(
              width: width * .45,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
            SizedBox(
              width: width * .10,
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 8.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Notifications {
  String? image;
  String? title;
  String? time;

  Notifications(this.image, this.title, this.time);
}
