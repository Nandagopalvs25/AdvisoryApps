import 'package:advisory_app/api.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:advisory_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'colorloader.dart';

class ProfileView extends StatefulWidget {
  final String username;

  const ProfileView({super.key, required this.username});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 60, left: 30),
            child: Text(
              "Student Profile",
              style: GoogleFonts.robotoCondensed(fontSize: 30),
            ),
          ),
          backgroundColor: const Color.fromARGB(47, 29, 87, 86),
        ),
        body: FutureBuilder(
          future: getUser(widget.username),
          builder: (context, snapshot) {
            Widget children;
            if (snapshot.hasData) {
              List<String> details = [
                snapshot.data?.batch ?? "",
                snapshot.data?.admission_number ?? "",
                snapshot.data?.email ?? "",
                snapshot.data?.phone_no ?? "",
                snapshot.data?.dob ?? "",
                snapshot.data?.guardian ?? "",
                snapshot.data?.guardian_no ?? "",
                snapshot.data?.teacher_remarks ?? "",
              ];

              List<String> var_details = [
                "Batch: ",
                "Admission No: ",
                "Email: ",
                "Mob No: ",
                "DOB: ",
                "Guardian: ",
                "Guardian no: ",
                "Remarks: "
              ];
              children = SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    //Text(snapshot.data?.username ?? ""),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                              RouteGenerator.studentEditPage,
                              arguments: widget.username);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: 30,
                        ),
                        tooltip: "Edit",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        width: 3),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: const NetworkImage(
                                      "https://media.discordapp.net/attachments/996754697849405540/1106485239670386719/profile.jpeg?width=400&height=400",
                                    ),
                                    backgroundColor: Colors.blue[300],
                                    radius: 60,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data?.username ?? "",
                                style: GoogleFonts.aclonica(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            shape: const CircleBorder(eccentricity: 0.4),
                            elevation: 2,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              tileColor:
                                  const Color.fromARGB(255, 193, 234, 255),
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 60),
                                        child: Text(
                                          var_details[index],
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.ptSerif(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Text(
                                          details[index],
                                          textAlign: TextAlign.start,
                                          style:
                                              GoogleFonts.ptSerif(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                              RouteGenerator.certificatePage,
                              arguments: snapshot.data!.activity);
                        },
                        child: const Text("Certificates"))
                  ],
                ),
              );
            } else {
              children = Scaffold(
                
                body: Center(
                  child: ColorLoader5(
                    dotOneColor: Colors.redAccent,
                    dotTwoColor: Colors.blueAccent,
                    dotThreeColor: Colors.green,
                    dotType: DotType.circle,
                    dotIcon: const Icon(
                      Icons.adjust,
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                ),
              );
            }

            return children;
          },
        ));
  }
}

Future<UserModel> getUser(String username) async {
  Baseapi api = Baseapi();
  http.Response res = await api.getUser(username);

  var user = UserModel.fromReqBody(res.body);

  return user;
  //String json = jsonEncode(user);
  //print(json);
}
