// Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Column(
//                               children: [
//                                 const SizedBox(
//                                   width: 180,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "First Name",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 180,
//                                   child: TextFormField(
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       border: OutlineInputBorder(),
//                                       hintText: 'First Name',
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your password';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 10),
//                             ),
//                             Column(
//                               children: [
//                                 const SizedBox(
//                                   width: 180,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Last Name",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 180,
//                                   child: TextFormField(
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       border: OutlineInputBorder(),
//                                       hintText: 'Last Name',
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your password';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Column(
//                               children: [
//                                 const SizedBox(
//                                   width: 180,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Birthdate",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 180,
//                                   child: TextFormField(
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       border: OutlineInputBorder(),
//                                       hintText: 'Birthdate',
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     controller: dateset,
//                                     onTap: () async {
//                                       // Below line stops keyboard from appearing
//                                       FocusScope.of(context)
//                                           .requestFocus(FocusNode());
//                                       // Show Date Picker Here
//                                       await _selectDate(context);
//                                       dateset.text =
//                                           DateFormat('yyyy/MM/dd').format(date);
//                                       //setState(() {});
//                                     },
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your password';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 10),
//                             ),
//                             Column(
//                               children: [
//                                 const SizedBox(
//                                   width: 180,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Mobile Number",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 180,
//                                   child: TextFormField(
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       border: OutlineInputBorder(),
//                                       hintText: 'Mobile Number',
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your password';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                         ),