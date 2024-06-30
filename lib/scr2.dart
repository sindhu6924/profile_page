import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:project_space_pro/main.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thub_profile/main.dart';
import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(Myapp());
// }
//
// // DevicePreview(builder: (context) =>
// class Myapp extends StatelessWidget {
//   const Myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: profilepage(),
//     );
//   }
// }

class profilepage extends StatefulWidget {
  final String certi;
  Map<String, dynamic> data4 = {};

  profilepage({super.key, required this.data4, required this.certi});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  Future Logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("emails");
    Fluttertoast.showToast(
        msg: "Logout successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16);

    Navigator.push(context, MaterialPageRoute(builder: (context) => log()));
  }

  final url =
      "https://thecodemind.io/app/student_project/thub_student_profile/api.php";
  List<dynamic> resData = [];
  List<dynamic> resfee = [];

  void fetchposts() async {
    await http
        .post(Uri.parse(url),
            body: jsonEncode(
                {"Action": "CertificationDetails", "Email": widget.certi}))
        .then((res) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        resData = jsonDecode(res.body);
        setState(() {});
        print(resData.toString());
      }
    }).onError((error, stackTrace) {
      throw Exception();
    });
  }

  void fetchposting() async {
    await http
        .post(Uri.parse(url),
            body: jsonEncode({"Action": "FeeDetails", "Email": widget.certi}))
        .then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        resfee = jsonDecode(response.body);
        setState(() {});
        print(resfee.toString());
      }
    }).onError((error, stackTrace) {
      throw Exception();
    });
  }

  @override
  void initState() {
    fetchposts();
    fetchposting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            children: [
              // Container(
              //   height: height / 6.9, //half of the height size
              //   width: width / 1,
              //   color: Color.fromARGB(255, 227, 227, 227),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: width / 1.3,
              //       ),
              //       Column(
              //         children: [
              //           SizedBox(
              //             height: height / 17,
              //           ),
              //           Container(
              //               height: height / 12,
              //               child: Image(
              //                 image: NetworkImage(
              //                     'https://play-lh.googleusercontent.com/EfMYUEEPsTnuwmbg0m4i8Sx_EhanSuLLUcXKWtwsJ2tqyvuarpbfhvI1_bQcWB6lFw=w240-h480-rw'),
              //               )),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.bottomCenter,
                height: height / 1.167, //half of the height size
                width: width / 1,
                color: Color.fromARGB(255, 227, 227, 227),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50, top: 50),
                            child: Image(
                              height: height / 9,
                              image: NetworkImage(
                                  'https://play-lh.googleusercontent.com/EfMYUEEPsTnuwmbg0m4i8Sx_EhanSuLLUcXKWtwsJ2tqyvuarpbfhvI1_bQcWB6lFw=w240-h480-rw'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomPaint(
                      size: Size(
                          height,
                          (height * 3)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(children: [
            SizedBox(
              height: height / 8.5,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                CircleAvatar(
                    radius: width / 6,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSktf_nNWDAaGR4bkJ8sJsyOaj33MsPKct51A&s"),
                    backgroundColor: Colors.transparent)
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Column(
              children: [
                Text(
                  "${widget.data4["Name"]}",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(138, 204, 168, 10)),
                ),
                Text(
                  "${widget.data4["Rollnumber"]}",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(138, 204, 168, 10)),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              width: width / 1.09,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 8, 51, 51),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.green.withOpacity(0.1),
                  //       offset: Offset(2, 2),
                  //       blurRadius: 5)
                  // ],
                  border: Border.all(
                      //width: 5,
                      color: Color.fromRGBO(138, 204, 168, 10)),
                  borderRadius: BorderRadius.circular(22.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 80,
                  ),
                  Row(
                    children: [
                      Text(
                        " TODAY'S CLASS:",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(138, 204, 168, 10)),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color.fromARGB(0, 0, 141, 89)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Present',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                  //fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 141, 89)),
                            ),
                          )),
                      Text(
                        '/',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(138, 204, 168, 10)),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color.fromARGB(0, 255, 0, 0),
                          ),
                          child: Text(
                            'Absent',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 100, 0, 0)),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height / 80,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            ' SESSIONS:8/10',
                            style: TextStyle(
                              color: Color.fromRGBO(138, 204, 168, 10),
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height / 60,
                          ),
                          const Text(
                            ' ATTENDENCE:80%',
                            style: TextStyle(
                              color: Color.fromRGBO(138, 204, 168, 10),
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: height / 60,
                          )
                        ],
                      ),
                      SizedBox(
                        width: width / 80,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 25,
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 8, 51, 51),
                  ),
                  child: ExpansionTile(
                    // collapsedBackgroundColor:
                    //     Color.fromARGB(255, 8, 51, 51),
                    collapsedIconColor: Color.fromRGBO(138, 204, 168, 10),
                    iconColor: Color.fromRGBO(138, 204, 168, 10),
                    backgroundColor: Color.fromARGB(255, 8, 51, 51),
                    title: Text(
                      'STUDENT DETAILS',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(138, 204, 168, 10)),
                    ),
                    // leading: Icon(Icons.keyboard_arrow_down),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'COLLEGE:${widget.data4["College"]}',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(138, 204, 168, 10)),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'BRANCH:${widget.data4["Branch"]}',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(138, 204, 168, 10)),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'PHONE NO:${widget.data4["Phonenumber"]}',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(138, 204, 168, 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 8, 51, 51),
                    ),
                    child: ExpansionTile(
                        collapsedIconColor: Color.fromRGBO(138, 204, 168, 10),
                        iconColor: Color.fromRGBO(138, 204, 168, 10),
                        backgroundColor: Color.fromARGB(255, 8, 51, 51),
                        title: Text(
                          'CERTIFICATIONS',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(138, 204, 168, 10)),
                        ),
                        // leading: Icon(Icons.keyboard_arrow_down),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: resData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  trailing: IconButton(
                                      onPressed: () {},
                                      icon: Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                launch(
                                                    "https://verify.technicalhub.io/certifications_soft_copies/IT%20Specialist%20Python/${widget.certi}.pdf");
                                              },
                                              child: Icon(Icons.download,
                                                  color: Color.fromRGBO(
                                                      138, 204, 168, 10))),
                                        ],
                                      )),
                                  title: Text(
                                    "${resData[index]["Certification"]}-${resData[index]["CertificationFrom"]}",
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15,
                                        //fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(138, 204, 168, 10)),
                                  ),
                                );
                              }),
                        ])),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 8, 51, 51),
                  ),
                  child: ExpansionTile(
                    collapsedIconColor: Color.fromRGBO(138, 204, 168, 10),
                    iconColor: Color.fromRGBO(138, 204, 168, 10),
                    backgroundColor: Color.fromARGB(255, 8, 51, 51),
                    title: Text(
                      'FEE DETAILS',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(138, 204, 168, 10)),
                    ),
                    // leading: Icon(Icons.keyboard_arrow_down),
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: resfee.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  ExpansionTile(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: resfee[index]["FeeDetails"]
                                              .length,
                                          itemBuilder: (context, int j) {
                                            return ExpansionTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Amount:${resfee[index]["FeeDetails"][j]["Amount"]}",
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 15,
                                                            //fontWeight: FontWeight.bold,
                                                            color:
                                                                Color.fromRGBO(
                                                                    138,
                                                                    204,
                                                                    168,
                                                                    10)),
                                                      ),
                                                      Text(
                                                        "CashCounter:${resfee[index]["FeeDetails"][j]["CashCounter"]},",
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 15,
                                                            //fontWeight: FontWeight.bold,
                                                            color:
                                                                Color.fromRGBO(
                                                                    138,
                                                                    204,
                                                                    168,
                                                                    10)),
                                                      ),
                                                      Text(
                                                          "PaymentId:${resfee[index]["FeeDetails"][j]["PaymentId"]}",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 15,
                                                              //fontWeight: FontWeight.bold,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      138,
                                                                      204,
                                                                      168,
                                                                      10))),
                                                      Text(
                                                          "PaidDate:${resfee[index]["FeeDetails"][j]["PaidDate"]}",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 15,
                                                              //fontWeight: FontWeight.bold,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      138,
                                                                      204,
                                                                      168,
                                                                      10)))
                                                    ],
                                                  ),
                                                )
                                              ],
                                              trailing: Lottie.asset(
                                                  "assets\Animation.json"),
                                              title: Text(
                                                  "Terms:${resfee[index]["FeeDetails"][j]["Term"]}"),
                                            );
                                          })
                                    ],
                                    title: Text(
                                      '${resfee[index]["Program"]}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15,
                                          //fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                              138, 204, 168, 10)),
                                    ),
                                    // trailing: GestureDetector(
                                    //     onTap: () {
                                    //       setState(() {
                                    //         ExpansionTile(
                                    //           trailing: ,
                                    //           collapsedIconColor:
                                    //               Color.fromRGBO(138, 204, 168, 10),
                                    //           iconColor:
                                    //               Color.fromRGBO(138, 204, 168, 10),
                                    //           backgroundColor:
                                    //               Color.fromARGB(255, 8, 51, 51),
                                    //           title: Text("Terms"),
                                    //           children: [
                                    //             ListView.builder(
                                    //                 shrinkWrap: true,
                                    //                 itemCount: resfee.length,
                                    //                 itemBuilder: (context, int i) {
                                    //                   return ListTile(
                                    //                     title: Text(
                                    //                         "${resfee[i]["FeeDetails"]}"),
                                    //                   );
                                    //                 })
                                    //           ],
                                    //         );
                                    //       });
                                    //     },
                                    //     child:
                                    //         Icon(Icons.arrow_forward_ios_outlined)),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ]),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 8, 51, 51), // foreground
              ),
              onPressed: () {},
              child: GestureDetector(
                onTap: () {
                  Logout();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => log()));
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Color.fromRGBO(138, 204, 168, 10)),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: height / 60,
          ),
        ]),
      ), //<Widget>[]

      backgroundColor: const Color(0xFF062525),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color(0xFF062525)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1502857);
    path_0.cubicTo(
        size.width * 0.4996667,
        size.height * 0.3505286,
        size.width * 0.554000,
        size.height * 0.1215571,
        size.width * 1.197333,
        size.height * 0.4099429);
    //path_0.cubicTo(size.width*0.4737000,size.height*0.169286,size.width*0.4811333,size.height*0.4994714,size.width*0.8022667,size.height*0.5019286);
    //path_0.cubicTo(size.width*0.6782000,size.height*0.5043714,size.width*0.7494667,size.height*0.4840143,size.width*0.8300000,size.height*0.5185714);
    //path_0.cubicTo(size.width*0.8697667,size.height*0.5650714,size.width*0.8999667,size.height*0.5759429,size.width*1.0066667,size.height*0.5657143);
    path_0.quadraticBezierTo(size.width * 1.0058333, size.height * 0.6739286,
        size.width * 1.0033333, size.height * 1.9985714);
    path_0.lineTo(size.width * -0.0081667, size.height * 2.0033429);
    path_0.quadraticBezierTo(size.width * -0.008120, size.height * 0.8585786, 0,
        size.height * 0.4242857);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color(0xFF0B4849)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
