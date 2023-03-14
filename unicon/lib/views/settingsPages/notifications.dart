import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});
  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  //Toggle values
  bool forGenNotif = true;
  bool forSound = false;
  bool forVibrate = true;
  bool forAppUpdates = false;
  bool forDeadlineReminders = true;
  bool forPromotion = true;
  bool forDiscounts = false;
  bool forPaymentReq = false;
  bool forMsgNotif = false;
  bool forCalls = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Notification Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        toolbarHeight: 75.0,
        leadingWidth: 30,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 225,
              width: MediaQuery.of(context).size.width - 10,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const ListTile(
                    title: Text(
                      "Common",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    title: const Text("General Notifications"),
                    trailing: Switch.adaptive(
                      activeColor: const Color.fromARGB(255, 84, 122, 70),
                      value: forGenNotif,
                      onChanged: (value) => setState(() => forGenNotif = value),
                    ),
                  ),
                  ListTile(
                    title: const Text("Sounds"),
                    trailing: Switch.adaptive(
                      activeColor: const Color.fromARGB(255, 84, 122, 70),
                      value: forSound,
                      onChanged: (value) => setState(() => forSound = value),
                    ),
                  ),
                  ListTile(
                    title: const Text("Vibrate"),
                    trailing: Switch.adaptive(
                      activeColor: const Color.fromARGB(255, 84, 122, 70),
                      value: forVibrate,
                      onChanged: (value) => setState(() => forVibrate = value),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            ),
            Container(
              height: 280,
              width: MediaQuery.of(context).size.width - 10,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ListTile(
                      title: Text(
                        "System & services update",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: const Text("App updates"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forAppUpdates,
                        onChanged: (value) =>
                            setState(() => forAppUpdates = value),
                      ),
                    ),
                    ListTile(
                      title: const Text("Deadline reminder"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forDeadlineReminders,
                        onChanged: (value) =>
                            setState(() => forDeadlineReminders = value),
                      ),
                    ),
                    ListTile(
                      title: const Text("Promotion"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forPromotion,
                        onChanged: (value) =>
                            setState(() => forPromotion = value),
                      ),
                    ),
                    ListTile(
                      title: const Text("Discount Available"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forDiscounts,
                        onChanged: (value) =>
                            setState(() => forDiscounts = value),
                      ),
                    ),
                    ListTile(
                      title: const Text("Payment Request"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forPaymentReq,
                        onChanged: (value) =>
                            setState(() => forPaymentReq = value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            ),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width - 10,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ListTile(
                      title: Text(
                        "Others",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: const Text("Message Notifications"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forMsgNotif,
                        onChanged: (value) =>
                            setState(() => forMsgNotif = value),
                      ),
                    ),
                    ListTile(
                      title: const Text("Calls"),
                      trailing: Switch.adaptive(
                        activeColor: const Color.fromARGB(255, 84, 122, 70),
                        value: forCalls,
                        onChanged: (value) => setState(() => forCalls = value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            ),
          ],
        ),
      ),
    );
  }
}
