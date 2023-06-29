import 'package:flutter/material.dart';

class Certificates extends StatefulWidget {
  const Certificates({super.key});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Certificates"),
        ),
        backgroundColor: const Color.fromARGB(47, 29, 87, 86),
      ),
    );
  }
}
