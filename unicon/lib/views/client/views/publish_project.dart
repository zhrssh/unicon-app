import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PublishProjectPage extends StatefulWidget {
  const PublishProjectPage({super.key});

  @override
  State<PublishProjectPage> createState() => _PublishProjectPageState();
}

class _PublishProjectPageState extends State<PublishProjectPage> {
  late TextEditingController _projectNameController;
  late TextEditingController _dateController;
  late TextEditingController _locationController;
  File? _image;
  bool allFieldsFilled =
      false; // boolean to detect whether text forms are filled

  // Function for getting image from gallery
  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveFile(image.path);

      setState(
        () {
          // ignore: unnecessary_this
          this._image = imagePermanent;
        },
      );
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  // Function to store the uploaded image
  Future<File> saveFile(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    // print(image);
    return File(imagePath).copy(image.path);
  }

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
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: Colors.black,
          ),
          leadingWidth: 30,
          title: const Text("Publish Project"),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
                    _image != null
                        ? Image.asset(
                            "assets/icons/check_icon.png",
                            height: 40,
                          )
                        : IconButton(
                            onPressed: () => getImage(),
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
                            hintText: "Date of start (yyyy-MM-dd)",
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                          ),
                          controller: _dateController,
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101));

                            if (pickeddate != null) {
                              setState(() {
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(pickeddate);
                              });
                            }
                          },
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
                        _publish(context);
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

void _publish(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        // padding: const EdgeInsets.all(16),
        height: 40,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 133, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Publish Press",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
