import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/src/features/book_appointment/views/book_appointment_screen.dart';
import 'package:mobile_app/src/features/patients/views/patient_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../add_user_info.dart';
import '../../../constant/images.dart';
import '../../book_appointment/views/appointment_submit_screen.dart';
import '../../diagnostics/views/diagnostics_page.dart';
import '../../doctors/views/doctors_screen.dart';
import '../../pharmacy/views/PharmacyHomePage.dart';


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
        surfaceTintColor:Colors.white12,
        backgroundColor: Colors.white12,
        toolbarHeight: 80,
        //elevation: 1,
        title: const Text(
          'Hi, Mr. Sourav',
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
              //color: Color(0xffF7E9DA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              image: DecorationImage(
                image: AssetImage(AppImages.homeBackground3),
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
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TableCalendar(
                              calendarStyle: const CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                selectedTextStyle: TextStyle(color: Colors.white),
                                todayTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),
                              ),
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientScreen()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 130,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // Expanded(
                                  //   child: Container(
                                  //     width: double.infinity,
                                  //     decoration: BoxDecoration(
                                  //       color: const Color(0xffFFE0DC),
                                  //       borderRadius: BorderRadius.circular(20),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: Colors.grey.withOpacity(0.5),
                                  //           spreadRadius: 3,
                                  //           blurRadius: 3,
                                  //           offset: const Offset(0, 3), // changes position of shadow
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     child:  const Column(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         Icon( FontAwesomeIcons.hospitalUser,size: 30,color: Colors.black54,),
                                  //         SizedBox(height: 5,),
                                  //         Text(
                                  //           'Patient Info',
                                  //           style: TextStyle(
                                  //             color: Colors.black,
                                  //             fontSize: 15,
                                  //             fontWeight: FontWeight.w700,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 12,),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorAppointmentPage()));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFBDC91).withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                ClipOval(
                                                  child: Icon( FontAwesomeIcons.userDoctor,size: 36,color: Colors.black54,),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Doctors Info',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      HapticFeedback.mediumImpact();

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddUserScreen()));

                    },
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      //  color: Colors.greenAccent,
                      margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
                      padding:  const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                      //  color:  Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(AppImages.appointmentBanner),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Diagnostics',style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),),
                          SizedBox(height: 5,),
                          Text('Add patient and Scan Tumour',style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),),
                        ],),
                    ),
                  ),
                  // Container(
                  //   height: 150,
                  //   //  color: Colors.greenAccent,
                  //   margin: const EdgeInsets.only(top: 15,left: 5,right: 5),
                  //   padding:  const EdgeInsets.all(5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: GestureDetector(
                  //           onTap: (){
                  //             HapticFeedback.mediumImpact();
                  //             Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosticsPage()));
                  //           },
                  //           child: Container(
                  //             alignment: Alignment.centerLeft,
                  //             padding: const EdgeInsets.only(left: 15),
                  //             height: 250,
                  //             // width: 280,
                  //             // padding: EdgeInsets.all(2),
                  //             decoration: BoxDecoration(
                  //               color:  Colors.white,
                  //               borderRadius: BorderRadius.circular(20),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.grey.withOpacity(0.5),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 2,
                  //                   offset: const Offset(0, 3), // changes position of shadow
                  //                 ),
                  //               ],
                  //               image: const DecorationImage(
                  //                 image: AssetImage(AppImages.diagnostics),
                  //                 fit: BoxFit.cover,
                  //                 colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  //
                  //               ),
                  //             ),
                  //             child: const Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text("Diagnostics",style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.w700,
                  //                 ),),
                  //                 Text("Get your diagnostics done",style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 15,),
                  //       Expanded(
                  //         flex: 2,
                  //         child: GestureDetector(
                  //           onTap: (){
                  //             HapticFeedback.mediumImpact();
                  //             Navigator.push(context, MaterialPageRoute(builder: (context) => const PharmacyHomePage()));
                  //           },
                  //           child: Container(
                  //             alignment: Alignment.centerLeft,
                  //             padding: const EdgeInsets.only(left: 15),
                  //             height: 250,
                  //             // width: 280,
                  //             // padding: EdgeInsets.all(2),
                  //             decoration: BoxDecoration(
                  //               color:  Colors.white,
                  //               borderRadius: BorderRadius.circular(20),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.grey.withOpacity(0.5),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 2,
                  //                   offset: const Offset(0, 3), // changes position of shadow
                  //                 ),
                  //               ],
                  //               image: const DecorationImage(
                  //                 image: AssetImage(AppImages.pharma),
                  //                 fit: BoxFit.cover,
                  //                 colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  //               ),
                  //             ),
                  //             child: const Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text("Pharmacy",style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.w700,
                  //                 ),),
                  //                 Text("Medicine & Health",style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //
                  //
                  //     ],
                  //   ),
                  // ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
