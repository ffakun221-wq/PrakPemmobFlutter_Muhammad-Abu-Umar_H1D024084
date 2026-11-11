import 'package:flutter/material.dart';
import 'package:flutter_modul2/sidemenu.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ), // AppBar
      body: const Center(
        child: Text('Ini adalah halaman About'),
      ), // Center
      drawer: const Sidemenu(),
    ); // Scaffold
  }
}
