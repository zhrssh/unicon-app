import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PublishProjectPage extends StatefulWidget {
  const PublishProjectPage({super.key});

  @override
  State<PublishProjectPage> createState() => _PublishProjectPageState();
}

class _PublishProjectPageState extends State<PublishProjectPage> {
  late TextEditingController _projectNameController;
  late TextEditingController _dateController;
  late TextEditingController _locationController;
  bool allFieldsFilled =
      false; // boolean to detect whether text forms are filled

  @override
  void initState() {
    _projectNameController = TextEditingController();
    _dateController = TextEditingController();
    _locationController = TextEditingController();

    // listners to all text fields
    _projectNameController.addListener(_checkAllFieldsFilled);
    _dateController.addListener(_checkAllFieldsFilled);
    _locationController.addListener(_checkAllFieldsFilled);
    super.initState();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void clearText() {
    _projectNameController.clear();
    _dateController.clear();
    _locationController.clear();
  }

  void _checkAllFieldsFilled() {
    setState(() {
      allFieldsFilled = _projectNameController.text.isNotEmpty &&
          _dateController.text.isNotEmpty &&
          _locationController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: Colors.black,
          ),
          leadingWidth: 30,
          title: const Text("Publish a New Project"),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          cursorColor: const Color.fromARGB(255, 98, 126, 88),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 228, 227, 227),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Project Name",
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          controller: _projectNameController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        height: 50,
                        child: Image.asset("assets/icons/upload.png"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: SizedBox(
                  height: 150,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(16),
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 98, 126, 88),
                      maxLines: 6,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 228, 227, 227),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: "Add a description",
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      // splashColor: const Color.fromARGB(255, 98, 126, 88),
                      splashColor: const Color.fromARGB(255, 98, 126, 88),
                      splashRadius: 22,
                      iconSize: 50,
                      icon: SizedBox(
                        child: Image.asset("assets/icons/Date.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          cursorColor: const Color.fromARGB(255, 98, 126, 88),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 228, 227, 227),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Date of start (MM/DD/YY)",
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                          ),
                          controller: _dateController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      // splashColor: const Color.fromARGB(255, 98, 126, 88),
                      splashColor: const Color.fromARGB(255, 98, 126, 88),
                      splashRadius: 22,
                      iconSize: 50,
                      icon: SizedBox(
                        child: Image.asset("assets/icons/Location2.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          cursorColor: const Color.fromARGB(255, 98, 126, 88),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 228, 227, 227),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Site/Project Location",
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                          ),
                          controller: _locationController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      // splashColor: const Color.fromARGB(255, 98, 126, 88),
                      splashColor: const Color.fromARGB(255, 98, 126, 88),
                      splashRadius: 22,
                      iconSize: 50,
                      icon: SizedBox(
                        child: Image.asset("assets/icons/cash.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          cursorColor: const Color.fromARGB(255, 98, 126, 88),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 228, 227, 227),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Price/Budget Range (PHP)",
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: allFieldsFilled
                    ? () {
                        _publish;
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 70),
                  disabledForegroundColor:
                      const Color.fromARGB(100, 84, 122, 70),
                  disabledBackgroundColor:
                      const Color.fromARGB(70, 84, 122, 70),
                  backgroundColor: const Color.fromARGB(255, 84, 122, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const SizedBox(
                  height: 60,
                  width: 250,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "PUBLISH",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _publish() {
  if (kDebugMode) {
    print("Publish button presesd");
  }
}
