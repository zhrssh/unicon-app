import 'package:flutter/material.dart';
import 'class.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MyAppExt());
  }
}

class MyAppExt extends StatefulWidget {
  const MyAppExt({super.key});

  @override
  State<MyAppExt> createState() => _MyAppExtState();
}

class _MyAppExtState extends State<MyAppExt> {
  String buttonName = 'Click';
  int currentIndex = 0;
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 55, 56),
      appBar: AppBar(
        toolbarHeight: 200,
        centerTitle: true,
        flexibleSpace: Container(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: ClipPath(
                  clipper: WaveClip(),
                  child: Container(
                    color: const Color.fromARGB(255, 89, 126, 130),
                    height: 180,
                  ),
                ),
              ),
              ClipPath(
                //upper clippath with less height
                clipper: WaveClip(), //set our custom wave clipper.
                child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  color: const Color.fromARGB(255, 139, 170, 173),
                  height: 150,
                  alignment: Alignment.center,
                  child: const Text(
                    "JUAN THE BUILDER",
                    style: TextStyle(
                      fontFamily:
                          '', //to set custom Font, must configured pubspec.yaml too
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          children: [
            Image.asset(
              'images/logo 1.png',
            ),
            const Text('Construction? We got you!')
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 28, 55, 56),
      ),
      body: Center(
        child: currentIndex == 0
            ? 
            Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(255, 28, 55, 56),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          buttonName = 'Clicked';
                        });
                      },
                      child: Text(buttonName),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NextPage(),
                          ),
                        );
                      },
                      child: const Text('Next Page'),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                },
                child: _isClicked
                    ? Image.asset('images/HammerLogo.png')
                    : Image.network(
                        'https://as1.ftcdn.net/v2/jpg/01/98/58/22/1000_F_198582218_TUbvIzt9aRJcC6crCiTwVJNV8lJqyRvH.jpg'),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'People',
            icon: Icon(Icons.accessibility),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
      ),
    );
  }
}


