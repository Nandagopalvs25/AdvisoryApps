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
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                clipBehavior: Clip.antiAlias,
                
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: InkWell(
                    onTap: () async {
                      String url = widget.acts[index].file_url ?? "";
                      if (!await launchUrl(Uri.parse(url))) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Column(
                          children: [
                            Text("Name: "),
                            Text("Start date:"),
                            Text("End date:")
                          ],
                        ),
                        Column(
                          children: [
                            Text(widget.acts[index].name ?? ""),
                            Text(widget.acts[index].start_date ?? ""),
                            Text(widget.acts[index].end_date ?? ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
