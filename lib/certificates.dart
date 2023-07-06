import 'package:advisory_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Certificates extends StatefulWidget {
  List<Activity> acts;
  Certificates({super.key, required this.acts});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  @override
  Widget build(BuildContext context) {
    print(widget.acts);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "Certificates",
            style: GoogleFonts.robotoCondensed(fontSize: 30),
          ),
        ),
        backgroundColor: const Color.fromARGB(47, 29, 87, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: widget.acts.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 140,
                child: Card(
                  elevation: 5,
                  shadowColor: const Color.fromARGB(255, 255, 159, 252),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 85, 255, 176),
                        Color.fromARGB(255, 99, 179, 244),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    width: 300,
                    height: 100,
                    child: InkWell(
                      onTap: () async {
                        String url = widget.acts[index].file_url ?? "";
                        if (!await launchUrl(Uri.parse(url))) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Name",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.arima(fontSize: 20),
                                    ),
                                    Text(
                                      widget.acts[index].name ?? "",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.fenix(fontSize: 23),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Start date",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.arima(fontSize: 20),
                                    ),
                                    Text(
                                      widget.acts[index].name ?? "",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.fenix(fontSize: 23),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "End date",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.arima(fontSize: 20),
                                    ),
                                    Text(
                                      widget.acts[index].name ?? "",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.fenix(fontSize: 23),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Text("Name: ",
                      //             style: GoogleFonts.sarabun(fontSize: 20)),
                      //         const SizedBox(
                      //           height: 10,
                      //         ),
                      //         Text("Start date:",
                      //             style: GoogleFonts.sarabun(fontSize: 20)),
                      //         const SizedBox(
                      //           height: 10,
                      //         ),
                      //         Text("End date:",
                      //             style: GoogleFonts.sarabun(fontSize: 20)),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           widget.acts[index].name ?? "",
                      //           style: GoogleFonts.questrial(fontSize: 20),
                      //         ),
                      //         const SizedBox(
                      //           height: 10,
                      //         ),
                      //         Text(
                      //           widget.acts[index].start_date ?? "",
                      //           style: GoogleFonts.questrial(fontSize: 20),
                      //         ),
                      //         const SizedBox(
                      //           height: 10,
                      //         ),
                      //         Text(
                      //           widget.acts[index].end_date ?? "",
                      //           style: GoogleFonts.questrial(fontSize: 20),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      //)
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
