// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart'as http;
// // String stringResponse='  ';
// // void main() {
// //   runApp(Myapp());
// // }
// //
// //
// // class Myapp extends StatelessWidget {
// //   const Myapp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       title: "GetApi",
// //       debugShowCheckedModeBanner: false ,
// //       home: HomePage(),
// //     );
// //   }
// // }
// //
// //
// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});
// //
// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //
// //   Future apicall() async {
// //     http.Response response;
// //     response= await http.get(Uri.parse("https://randomuser.me/api/?results=100"));
// //
// //     if(response.statusCode==200){
// //       setState(() {
// //         stringResponse=response.body;
// //       });
// //     }
// //   }
// //   // TextEditingController email=TextEditingController();
// //   @override
// //   void initState() {
// //     apicall();
// //     super.initState();
// //   }
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         scrollDirection: Axis.vertical,
// //         child: Column(
// //           children: [
// //                Text(stringResponse.toString(),style: TextStyle(color: Colors.black),),
// //             // TextFormField(
// //             //   controller: email,
// //             // ),
// //             // ElevatedButton(
// //             //     onPressed: (){
// //             //   Navigator.push(context, MaterialPageRoute(builder: (context)=>stringRespons()));
// //             // }, child:Text("click me"))
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // // class stringRespons extends StatefulWidget {
// // //   const stringRespons({super.key});
// // //
// // //   @override
// // //   State<stringRespons> createState() => _stringResponsState();
// // // }
// // //
// // // class _stringResponsState extends State<stringRespons> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Text(stringResponse.toString(),style: TextStyle(color: Colors.black),);
// // //   }
// // // }
//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(myapp());
// }
//
// class myapp extends StatelessWidget {
//   const myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: apikey(),
//     );
//   }
// }
//
// class apikey extends StatefulWidget {
//   const apikey({super.key});
//
//   @override
//   State<apikey> createState() => _apikeyState();
// }
//
// class _apikeyState extends State<apikey> {
//   List<dynamic> users = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('rest API call'),
//       ),
//       body: ListView.builder(
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final user = users[index];
//             final name = user['name']['first'];
//             final email = user['email'];
//             final imageUrl = user['picture']['thumbnail'];
//             return ListTile(
//               leading: CircleAvatar(
//                   child: Image.network(imageUrl)
//               ),
//               title: Text(name.toString()),
//               subtitle: Text(email),
//             );
//           }),
//       floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
//     );
//   }
//
//   void fetchUsers() async {
//     print('fetchUsers called');
//     const url = 'https://randomuser.me/api/?results=100';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       users = json['results'];
//     });
//     print('fetchUsers completed');
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/////import 'package:gettingapi/scr1.dart';
/////import 'package:gettingapi/screen1.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thub_profile/scr1.dart';

class MyHttpCertError extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString("emails");
  HttpOverrides.global = MyHttpCertError();
  TextEditingController emails = TextEditingController();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email == null ? log() : AlternateScreen(text: email.trim())));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: log(),
//     );
//   }
// }

class log extends StatefulWidget {
  const log({super.key});

  @override
  State<log> createState() => _logState();
}

class _logState extends State<log> {
  TextEditingController emails = TextEditingController();
  TextEditingController passwords = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var _obscure = true;

  List<dynamic> data = [];
  // TextEditingController password=TextEditingController();
  void login(String email, String password) async {
    try {
      final response = await http
          .post(
              Uri.parse(
                  "https://thecodemind.io/app/student_project/thub_student_profile/api.php"),
              body: jsonEncode({
                "Action": "Login",
                "Email": emails.text.trim().toString(),
                "Password": passwords.text.trim().toString()
              }))
          .then((response) async {
        if (response.statusCode == 200) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("emails", emails.text);
          print(response.body);
          String _text = emails.text.trim().toString();
          print(_text);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AlternateScreen(text: _text)));
          Fluttertoast.showToast(
              msg: "Login successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);

          //data = jsonEncode(response.body);
          //print(temp["roll_number"]);
          // print("login ");

          // if (data.length != 0) {
          //   Navigator.push(context,
          //       MaterialPageRoute(
          //         builder: (context) => AlternateScreen(text: _text),));
          //   print(response.body);
          // }
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
    } catch (e) {
      print(e.toString());
    }
  }

  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C5F2D),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: RoundedDiagonalPathClipper(),
                    child: Container(
                      height: 400,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Colors.white,
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 90.0,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: emails,
                                    validator: (val) => val!.length == 0
                                        ? "Enter the email"
                                        : null,
                                    decoration: InputDecoration(
                                        hintText: "Email address",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        icon: const Icon(
                                          Icons.email,
                                          color:
                                              Color.fromARGB(255, 0, 141, 89),
                                        )),
                                  )),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, bottom: 10.0),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: passwords,
                                    validator: (val) => val!.length == 0
                                        ? "Enter the password"
                                        : null,
                                    obscureText: _obscure,
                                    style: const TextStyle(color: Colors.black),
                                    obscuringCharacter: ".",
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        suffixIcon: IconButton(
                                          icon: _obscure
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _obscure = !_obscure;
                                            });
                                          },
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        icon: const Icon(
                                          Icons.lock,
                                          color:
                                              Color.fromARGB(255, 0, 141, 89),
                                        )),
                                  )),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, bottom: 10.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Color(0xFF6cbd3a),
                        child: Icon(
                          Icons.person,
                          color: const Color(0xFF062525),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 420,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          backgroundColor: Color.fromARGB(255, 0, 141, 89),
                        ),
                        onPressed: () {
                          login(emails.text.toString(),
                              passwords.text.toString());
                          setState(() {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => profilepage()));
                          });
                        },
                        child: const Text("Login",
                            style: TextStyle(color: const Color(0xFF062525))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            )
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextFormField(
      //
      //         controller: emails,
      //         decoration: InputDecoration(
      //           hintText: "email",
      //         ),
      //       ),
      //       TextFormField(
      //         controller: passwords,
      //         decoration: InputDecoration(
      //
      //           hintText: "email",
      //         ),
      //       ),
      //
      //       ElevatedButton(onPressed: (){
      //
      //
      //           //emails.clear();
      //           login(emails.text.toString(),passwords.text.toString());
      //
      //         //Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen1()));
      //
      //       }, child: Text("sign in")),
      //
      //       // Text(data[0]["roll_number"]
      //     ],
      //   ),
      // ),
    );
  }
}
// class Screen1 extends StatefulWidget {
//   const Screen1({super.key});
//
//   @override
//   State<Screen1> createState() => _Screen1State();
// }
// ontext context) {
//     return Scaffold(
//       body: Center(child: Text("Title:${jsonPost["placed_companies"]}")),
//     );
//   }
// }
//
