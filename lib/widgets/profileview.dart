import 'package:advisory_app/api.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color.fromARGB(255, 0, 0, 0),
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
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            shape: const CircleBorder(eccentricity: 0.4),
                            shadowColor: Colors.black,
                            elevation: 3,
                            child: ListTile(
                              
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              tileColor: const Color.fromARGB(255, 193, 234, 255),
                              
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 60),
                                        child: Text(
                                          var_details[index],
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.ptSerif(fontSize: 17,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Text(
                                          details[index],
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.ptSerif(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else {
              children = const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
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
