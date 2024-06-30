import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/////import 'package:gettingapi/scr1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thub_profile/main.dart';
import 'package:thub_profile/scr2.dart';

// class AlternateScreen extends StatelessWidget {
//   final String text;
//
//
//   AlternateScreen({required this.text});
//   List<dynamic> data=[];
//   void details(String info) async{
//     try {
//       final response = await http.post(Uri.parse(
//           "https://thecodemind.io/app/student_project/thub_student_profile/api.php"),
//           body: jsonEncode({
//             "Rollnumber": text,
//
//           })).then((response) {
//         if (response.statusCode == 200) {
//           print(response.body);
//
//
//           //Navigator.push(context, MaterialPageRoute(builder: (context)=>AlternateScreen(text: _text)));
//           //data = jsonEncode(response.body);
//           //print(temp["roll_number"]);
//           // print("login ");
//
//
//         }
//       }
//         );
//
//     }catch(e){
//       print(e.toString());
//     }
//   }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Alternate Screen'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Center(
//           child: Text(
//             text.toString(),
//             style: TextStyle(fontSize: 18.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
class AlternateScreen extends StatefulWidget {
  final String text;

  const AlternateScreen({super.key, required this.text});

  @override
  State<AlternateScreen> createState() => _AlternateScreenState();
}

class _AlternateScreenState extends State<AlternateScreen> {
  String email = " ";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString("email").toString();
    });
  }

  // Future Logout() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.remove("emails");
  //   Fluttertoast.showToast(
  //             msg: "Logout successful",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.SNACKBAR,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.green,
  //             textColor: Colors.white,
  //             fontSize: 16);

  //   Navigator.push(context, MaterialPageRoute(builder: (context) => log()));
  // }

  @override
  void initState() {
    super.initState();
    details(widget.text);
    getEmail();
  }

  Map<String, dynamic> data3 = {};

  void details(String roll) async {
    print(roll);
    try {
      final response = await http
          .post(
              Uri.parse(
                  "https://thecodemind.io/app/student_project/thub_student_profile/api.php"),
              body: jsonEncode({
                "Action": "Details",
                "Email": roll,
              }))
          .then((responses) {
        data3 = jsonDecode(responses.body);
        setState(() {
          //print(data3);
        });
        print(data3["Phonenumber"]);

        //if ( data3[0]["RollNumber"]==widget.text.toString()) {

        // print(data3);
        // String _text=emails.text.trim().toString();
        // print(_text);

        //Navigator.push(context, MaterialPageRoute(builder: (context)=>AlternateScreen(text: _text)));
        //data3= jsonEncode(response.body);
        //}
        if (data3.length != 0) {
          print(responses.body);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('The username does not exist.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          // alignment: Alignment(0 , 6),
          children: [
            Container(
              height: h * 0.5 + 5,
              width: w,
              child: const Image(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSktf_nNWDAaGR4bkJ8sJsyOaj33MsPKct51A&s"),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              child: CustomPaint(
                size: Size(
                    w,
                    (w * 2.3333333333333335)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .52,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${data3["Name"]} ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(138, 204, 168, 10)),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.tealAccent, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(32, 78, 78, 1)),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 40,
                              shadowColor: Color.fromRGBO(32, 78, 78, 1),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 25),
                                      Row(
                                        children: [
                                          Text(
                                            "Rollnumber     ",
                                            style: TextStyle(
                                                fontSize: h / 50,
                                                color: Color.fromRGBO(
                                                    138, 204, 168, 10)),
                                          ),
                                          Text(
                                            ": ${data3["Rollnumber"]}",
                                            style: TextStyle(
                                                fontSize: h / 50,
                                                color: Color.fromRGBO(
                                                    138, 204, 168, 10)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text("College        ",
                                              style: TextStyle(
                                                  fontSize: h / 50,
                                                  color: Color.fromRGBO(
                                                      138, 204, 168, 10))),
                                          Text(
                                            "    : ${data3["College"]}",
                                            style: TextStyle(
                                                fontSize: h / 50,
                                                color: Color.fromRGBO(
                                                    138, 204, 168, 10)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text("Branch            ",
                                              style: TextStyle(
                                                  fontSize: h / 50,
                                                  color: Color.fromRGBO(
                                                      138, 204, 168, 10))),
                                          Text(" : ${data3["Branch"]}",
                                              style: TextStyle(
                                                  fontSize: h / 50,
                                                  color: Color.fromRGBO(
                                                      138, 204, 168, 10))),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Passout Year ",
                                            style: TextStyle(
                                                fontSize: h / 50,
                                                color: Color.fromRGBO(
                                                    138, 204, 168, 10)),
                                          ),
                                          Text(
                                            " : ${data3["Passoutyear"]}      ",
                                            style: TextStyle(
                                                fontSize: h / 50,
                                                color: Color.fromRGBO(
                                                    138, 204, 168, 10)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Email     ",
                                              style: TextStyle(
                                                  fontSize: h / 50,
                                                  color: Color.fromRGBO(
                                                      138, 204, 168, 10)),
                                            ),
                                            Text(
                                              " : ${data3["Email"]}          ",
                                              style: TextStyle(
                                                  fontSize: h / 50,
                                                  color: Color.fromRGBO(
                                                      138, 204, 168, 10)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            height: h / 4,
                            width: w / 1.1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => profilepage(
                                        data4: data3, certi: widget.text)));
                          },
                          child: Text(
                            "MORE",
                            style: TextStyle(
                                color: Color.fromRGBO(138, 204, 168, 10),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color(0xff0B3849)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..shader = ui.Gradient.linear(
          Offset(0, 0),
          Offset(size.width, size.height),
          [Color(0xFF0B4948), Color(0xFF062525)])
      ..strokeJoin = StrokeJoin.miter;

    // Path path_0 = Path();
    // path_0.moveTo(0,size.height*0.3542857);
    // path_0.cubicTo(size.width*0.066667,size.height*0.315286,size.width*0.1796000,size.height*0.4395571,size.width*0.2207333,size.height*0.3850429);
    // path_0.cubicTo(size.width*0.2137000,size.height*0.4969286,size.width*1.1911333,size.height*0.394714,size.width*2.998009967,size.height*0.5600000);
    // path_0.cubicTo(size.width*111.0382000,size.height*11.3943714,size.width*2.0094667,size.height*10.5340143,size.width*9.9900000,size.height*9.2095714);
    // // path_0.cubicTo(size.width*2.677667,size.height*8.4350714,size.width*3.9900667,size.height*2.4350714,size.width*1.0116667,size.height*4.3957143);
    // path_0.quadraticBezierTo(size.width*3.0058333,size.height*0.6739286,size.width*1.0033333,size.height*0.9985714);
    // path_0.lineTo(size.width*-0.0081667,size.height*1.0183429);
    // // path_0.quadraticBezierTo(size.width*-0.0061250,size.height*0.8585786,0,size.height*0.4242857);
    // path_0.close();

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.3402857);
    path_0.cubicTo(
        size.width * 0.4996667,
        size.height * 0.5505286,
        size.width * 0.554000,
        size.height * 0.3215571,
        size.width * 1.197333,
        size.height * 0.4899429);
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

    Paint paint_stroke_0 = Paint()
      ..color = const Color(0xFF162525)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..shader = ui.Gradient.linear(
          Offset(0, 0),
          Offset(size.width, size.height),
          [Color(0xFF0B4948), Color(0xFF062525)])
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
