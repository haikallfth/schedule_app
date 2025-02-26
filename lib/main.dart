import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:schedule_app/ui/home.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // berfungsi untuk mengubah warna atau style dari bagian navbar kamera (jam, wifi dan batre)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // Membuat splash screen (kyk tampilan pertama yg di tampilkan ketika membuka app selama 3 detik), HARUS STATEFULL GABISA STATELESS soalnya kita make initState dan initState itu miliknya si STATEFULL
    Future.delayed(const Duration(seconds: 5)).then((_){
      //Naigator pushReplacement dipake agar ketika splash screen telah di jalankan dan sudah selesai kita tidak bisa balik lg ke halaman splash screen kecuali di reload ulang
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),),);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D3E50),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('AstraPlan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}

