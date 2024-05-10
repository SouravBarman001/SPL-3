import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../constant/images.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        toolbarHeight: 80,
        //elevation: 1,
        title: const Text(
          'Hi, Dr Sourav',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: Image.asset(AppImages.profile1,height: 50,width: 50,),
                )
              ],
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              image: DecorationImage(
                image: AssetImage(AppImages.homeBackground2),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    //  color: Colors.greenAccent,
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Container(
                            // height: 280,
                            // width: 280,
                            // padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TableCalendar(
                              shouldFillViewport: true,
                              //  headerVisible: false,
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: 130,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(AppImages.patient,width: 50,height: 50,),
                                        const Text('Patient : 12',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12,),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(AppImages.timer,width: 50,height: 50,),
                                        Text('Set Timer',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    height: 220,
                    //  color: Colors.greenAccent,
                    margin: const EdgeInsets.only(top: 20,left: 5,right: 5),
                    padding:  EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            height: 250,
                            // width: 280,
                            // padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text("Box-1"),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            height: 250,
                            // width: 280,
                            // padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text("Box-2"),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
