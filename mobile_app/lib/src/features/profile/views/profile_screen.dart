import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              //o: Overflow.visible,
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.loose,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(30),
                    //   bottomRight: Radius.circular(30),
                    // ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 50,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  top: 110,
                  left: MediaQuery.of(context).size.width / 2 - 60,
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 57,
                      child: Icon(FontAwesomeIcons.userCheck,size: 50,),
                    ),
                  ),
                ),
                // Positioned(
                //   top: 180,
                //   left: MediaQuery.of(context).size.width / 2 + 10,
                //   child: CircleAvatar(
                //     radius: 12,
                //     backgroundColor: Colors.blue,
                //     child: Icon(
                //       FontAwesomeIcons.pen,
                //       color: Colors.white,
                //       size: 12,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'First Name',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Aaron',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Last Name',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Graham',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'aarong@gmail.com',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Birth',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    trailing: const Text(
                      '08-05-24', style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    trailing: const Text(
                    'Male', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.lock,color: Colors.white70,),
                    label: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 18,
                          color: Colors.white70,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.signOutAlt, color: Colors.red),
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 50),
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
}
